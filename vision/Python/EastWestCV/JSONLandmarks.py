import os
import cv2
import numpy as np
import mediapipe as mp
import shutil
import json
import random

input_root = r"C:\Users\jesal\Downloads\Images of American Sign Language (ASL) Alphabet Gestures\Images of American Sign Language (ASL) Alphabet Gestures\Root\Root\Type_05_(Enhanced_Skeleton)"
output_root = r"C:\Users\jesal\Downloads\Images of American Sign Language (ASL) Alphabet Gestures\Images of American Sign Language (ASL) Alphabet Gestures\Root"
output_skeleton_only = os.path.join(output_root, 'mediapipeSkeleton')
error_log_file = os.path.join(output_root, 'errorfolder', 'error.txt')
landmarks_json_file = os.path.join(output_root, 'landmarks_data.json')
skip_letters = ['j', 'z', 'del', 'nothing', 'space']

os.makedirs(output_skeleton_only, exist_ok=True)
os.makedirs(os.path.dirname(error_log_file), exist_ok=True)

mp_hands = mp.solutions.hands
hands = mp_hands.Hands(static_image_mode=True, max_num_hands=1, min_detection_confidence=0.5)

HAND_CONNECTIONS = [
    (0, 1), (1, 2), (2, 3), (3, 4),
    (0, 5), (5, 6), (6, 7), (7, 8),
    (5, 9), (9, 10), (10, 11), (11, 12),
    (9, 13), (13, 14), (14, 15), (15, 16),
    (13, 17), (17, 18), (18, 19), (19, 20),
    (0, 17)
]

error_files = []
letters_summary = {}
landmarks_data = {}

for letter in os.listdir(input_root):
    if letter.lower() in skip_letters:
        continue
    letter_dir = os.path.join(input_root, letter)
    if not os.path.isdir(letter_dir):
        continue
    letters_summary[letter] = {"total": 0, "errors": 0}
    landmarks_data[letter] = {}
    out_dir_skel = os.path.join(output_skeleton_only, letter)
    os.makedirs(out_dir_skel, exist_ok=True)
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
            tx = (x - bb_center_x) * scale_factor + image_center_x
            ty = (y - bb_center_y) * scale_factor + image_center_y
            transformed_points.append((int(tx), int(ty)))
        blank_image = np.zeros_like(image)
        for start_idx, end_idx in HAND_CONNECTIONS:
            x1, y1 = transformed_points[start_idx]
            x2, y2 = transformed_points[end_idx]
            cv2.line(blank_image, (x1, y1), (x2, y2), (255, 255, 255), 2)
            cv2.circle(blank_image, (x1, y1), 4, (0, 0, 255), -1)
            cv2.circle(blank_image, (x2, y2), 4, (0, 0, 255), -1)
        out_path_skel = os.path.join(out_dir_skel, file)
        cv2.imwrite(out_path_skel, blank_image)
        landmarks_dict = {str(i): [pt[0], pt[1]] for i, pt in enumerate(transformed_points)}
        image_id = os.path.splitext(file)[0]
        landmarks_data[letter][image_id] = landmarks_dict

with open(error_log_file, 'w') as f:
    for error_file in error_files:
        f.write(error_file + "\n")

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
print("Process complete")

with open(landmarks_json_file, 'w') as f:
    json.dump(landmarks_data, f, indent=4)

letter_files = {}
for letter in os.listdir(output_skeleton_only):
    letter_path = os.path.join(output_skeleton_only, letter)
    if not os.path.isdir(letter_path):
        continue
    files = [f for f in os.listdir(letter_path) if f.lower().endswith('.jpg')]
    letter_files[letter] = files

if letter_files:
    global_min = min(len(files) for files in letter_files.values())
    print(f"\nUndersampling: reducing to {global_min} images.")
    for letter, files in letter_files.items():
        current_count = len(files)
        if current_count > global_min:
            num_to_delete = current_count - global_min
            files_to_delete = random.sample(files, num_to_delete)
            for file in files_to_delete:
                file_path = os.path.join(output_skeleton_only, letter, file)
                try:
                    os.remove(file_path)
                    print(f"Deleted {file_path}")
                except Exception as e:
                    print(f"Error {file_path}: {e}")

print("Undersampling complete")
