import os
import cv2
import numpy as np
import mediapipe as mp
import shutil

# ===============================
# Setup: Directories and Configurations
# ===============================
dataset_dir = r'C:\Users\LLR User\Downloads\pointnet_hands-main\pointnet_hands-main\asl_alphabet_train\asl_alphabet_train'
results_dir = r'C:\Users\LLR User\Downloads\pointnet_hands-main\pointnet_hands-main\results'
output_with_bg = os.path.join(results_dir, 'mediapipeHands')
output_skeleton_only = os.path.join(results_dir, 'mediapipeSkeleton')
new_dataset_dir = os.path.join(results_dir, 'newdataset')
error_log_file = os.path.join(results_dir, 'errorfolder', 'error.txt')
skip_letters = ['j', 'z', 'del', 'nothing', 'space']

# Create necessary directories if they don't exist
os.makedirs(output_with_bg, exist_ok=True)
os.makedirs(output_skeleton_only, exist_ok=True)
os.makedirs(new_dataset_dir, exist_ok=True)
os.makedirs(os.path.dirname(error_log_file), exist_ok=True)

# ===============================
# Setup: Mediapipe Hands
# ===============================
mp_hands = mp.solutions.hands
hands = mp_hands.Hands(
    static_image_mode=True,
    max_num_hands=1,
    min_detection_confidence=0.5
)
mp_drawing = mp.solutions.drawing_utils

# Define hand connections for drawing
HAND_CONNECTIONS = [
    (0, 1), (1, 2), (2, 3), (3, 4),
    (0, 5), (5, 6), (6, 7), (7, 8),
    (5, 9), (9, 10), (10, 11), (11, 12),
    (9, 13), (13, 14), (14, 15), (15, 16),
    (13, 17), (17, 18), (18, 19), (19, 20),
    (0, 17)
]

# ===============================
# Processing Images: Per Letter
# ===============================
error_files = []
letters_summary = {}

for letter in os.listdir(dataset_dir):
    if letter.lower() in skip_letters:
        continue

    letter_dir = os.path.join(dataset_dir, letter)
    if not os.path.isdir(letter_dir):
        continue

    letters_summary[letter] = {"total": 0, "errors": 0}

    # Create output folders for this letter
    out_dir_with_bg = os.path.join(output_with_bg, letter)
    out_dir_skel = os.path.join(output_skeleton_only, letter)
    new_letter_dir = os.path.join(new_dataset_dir, letter)
    os.makedirs(out_dir_with_bg, exist_ok=True)
    os.makedirs(out_dir_skel, exist_ok=True)
    os.makedirs(new_letter_dir, exist_ok=True)

    for file in os.listdir(letter_dir):
        if not file.lower().endswith('.jpg'):
            continue

        letters_summary[letter]["total"] += 1
        img_path = os.path.join(letter_dir, file)
        image = cv2.imread(img_path)
        if image is None:
            error_files.append(img_path)
            letters_summary[letter]["errors"] += 1
            continue

        image_rgb = cv2.cvtColor(image, cv2.COLOR_BGR2RGB)
        results = hands.process(image_rgb)
        if not results.multi_hand_landmarks:
            error_files.append(img_path)
            letters_summary[letter]["errors"] += 1
            continue

        # Save annotated image (with background)
        annotated_image = image.copy()
        for hand_landmarks in results.multi_hand_landmarks:
            mp_drawing.draw_landmarks(
                annotated_image,
                hand_landmarks,
                mp_hands.HAND_CONNECTIONS
            )
        out_path_with_bg = os.path.join(out_dir_with_bg, file)
        cv2.imwrite(out_path_with_bg, annotated_image)

        # Save skeleton-only image
        blank_image = np.zeros_like(image)
        h, w, _ = image.shape
        hand_landmarks = results.multi_hand_landmarks[0].landmark
        pts = np.array([[lm.x * w, lm.y * h] for lm in hand_landmarks])
        min_x, max_x = np.min(pts[:, 0]), np.max(pts[:, 0])
        min_y, max_y = np.min(pts[:, 1]), np.max(pts[:, 1])
        bb_width = max(max_x - min_x, 1)
        bb_height = max(max_y - min_y, 1)
        scale_factor = 0.9 * min(w / bb_width, h / bb_height)
        bb_center_x = (min_x + max_x) / 2.0
        bb_center_y = (min_y + max_y) / 2.0
        image_center_x, image_center_y = w / 2.0, h / 2.0
        transformed_points = []
        for x, y in pts:
            x = (x - bb_center_x) * scale_factor + image_center_x
            y = (y - bb_center_y) * scale_factor + image_center_y
            transformed_points.append((int(x), int(y)))
        for start_idx, end_idx in HAND_CONNECTIONS:
            x1, y1 = transformed_points[start_idx]
            x2, y2 = transformed_points[end_idx]
            cv2.line(blank_image, (x1, y1), (x2, y2), (255, 255, 255), 2)
            cv2.circle(blank_image, (x1, y1), 4, (0, 0, 255), -1)
            cv2.circle(blank_image, (x2, y2), 4, (0, 0, 255), -1)
        out_path_skel = os.path.join(out_dir_skel, file)
        cv2.imwrite(out_path_skel, blank_image)

        # Copy original image to new dataset folder
        shutil.copy(img_path, os.path.join(new_letter_dir, file))
        print(f"Processed image: {img_path}")

# Write error log
with open(error_log_file, 'w') as f:
    for error_file in error_files:
        f.write(error_file + "\n")

print("\nProcessing Summary (per letter):")
for letter, stats in letters_summary.items():
    total = stats["total"]
    errors = stats["errors"]
    processed = total - errors
    success_percentage = (processed / total * 100) if total > 0 else 0.0
    print(f"Letter: {letter}")
    print(f"  Total images:    {total}")
    print(f"  Processed:       {processed}")
    print(f"  Errors:          {errors}")
    print(f"  Success Rate:    {success_percentage:.2f}%")
    print("-" * 40)

hands.close()
print("Processing complete. Check the output folders and error log for details.")

# ===============================
# Undersampling: Balancing Dataset Across Letters
# ===============================
# For each of the three output directories, we first find the minimum number of images
# across all letter folders. Then, for every letter folder that has more images than this
# global minimum, we delete the extra images (choosing from the end of the sorted list).

output_dirs = [output_with_bg, output_skeleton_only, new_dataset_dir]

for out_dir in output_dirs:
    # Gather counts and sorted file lists for each letter folder in the directory
    letter_counts = {}
    letter_folders = {}
    for letter in os.listdir(out_dir):
        letter_path = os.path.join(out_dir, letter)
        if not os.path.isdir(letter_path):
            continue
        files = [f for f in os.listdir(letter_path) if f.lower().endswith('.jpg')]
        letter_counts[letter] = len(files)

        # Sort files using numeric sort if possible; otherwise, lexicographically
        def sort_key(filename):
            name, _ = os.path.splitext(filename)
            return int(name) if name.isdigit() else name
        letter_folders[letter] = sorted(files, key=sort_key)

    if not letter_counts:
        continue

    # Find the global minimum count across all letters in this directory
    global_min = min(letter_counts.values())
    print(f"\nIn directory '{out_dir}', undersampling each letter to {global_min} images.")

    # For each letter, delete extra images if its count exceeds the global minimum
    for letter, files_sorted in letter_folders.items():
        current_count = len(files_sorted)
        if current_count > global_min:
            num_to_delete = current_count - global_min
            # Delete images from the end (i.e., those with the highest numeric or lex order)
            files_to_delete = files_sorted[-num_to_delete:]
            for file in files_to_delete:
                file_path = os.path.join(out_dir, letter, file)
                try:
                    os.remove(file_path)
                    print(f"Deleted {file_path}")
                except Exception as e:
                    print(f"Error deleting {file_path}: {e}")

print("Undersampling complete. Your dataset is now balanced across letters.")
