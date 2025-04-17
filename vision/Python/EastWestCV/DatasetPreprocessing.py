import os
import cv2
import mediapipe as mp
import numpy as np
import random

input_root = r"C:\Users\jesal\Downloads\Images of American Sign Language (ASL) Alphabet Gestures\Images of American Sign Language (ASL) Alphabet Gestures\Root\Root\Type_05_(Enhanced_Skeleton)"
output_root = r"C:\Users\jesal\Downloads\Images of American Sign Language (ASL) Alphabet Gestures\Images of American Sign Language (ASL) Alphabet Gestures\Root"

error_log_path = os.path.join(output_root, "errors.txt")
FINAL_W, FINAL_H = 200, 200

if not os.path.exists(output_root):
    os.makedirs(output_root)
if os.path.exists(error_log_path):
    os.remove(error_log_path)

mp_hands = mp.solutions.hands
HAND_CONNECTIONS = [
    (0, 1), (1, 2), (2, 3), (3, 4),
    (0, 5), (5, 6), (6, 7), (7, 8),
    (5, 9), (9, 10), (10, 11), (11, 12),
    (9, 13), (13, 14), (14, 15), (15, 16),
    (13, 17), (17, 18), (18, 19), (19, 20),
    (0, 17)
]

folder_counts = {}

def augment_image(image):
    rows, cols = image.shape[:2]
    angle = random.uniform(-15, 15)
    tx = random.uniform(-10, 10)
    ty = random.uniform(-10, 10)
    M = cv2.getRotationMatrix2D((cols/2, rows/2), angle, 1)
    M[0, 2] += tx
    M[1, 2] += ty
    augmented = cv2.warpAffine(image, M, (cols, rows), borderMode=cv2.BORDER_CONSTANT, borderValue=(0, 0, 0))
    return augmented

input_folder_counts = {}
for folder_name in os.listdir(input_root):
    subfolder_input = os.path.join(input_root, folder_name)
    if not os.path.isdir(subfolder_input):
        continue
    image_files = [f for f in os.listdir(subfolder_input) if f.lower().endswith(('.png', '.jpg', '.jpeg'))]
    input_folder_counts[folder_name] = len(image_files)
target_max_count = max(input_folder_counts.values()) if input_folder_counts else 0
print(f"Max Num of Images in all folders: {target_max_count}")

with mp_hands.Hands(static_image_mode=True, max_num_hands=1, min_detection_confidence=0.5) as hands:
    for folder_name in os.listdir(input_root):
        subfolder_input = os.path.join(input_root, folder_name)
        subfolder_output = os.path.join(output_root, folder_name)
        if not os.path.isdir(subfolder_input):
            continue
        if not os.path.exists(subfolder_output):
            os.makedirs(subfolder_output)
        count = 0

        for image_name in os.listdir(subfolder_input):
            image_path = os.path.join(subfolder_input, image_name)
            image = cv2.imread(image_path)
            if image is None:
                continue

            image_rgb = cv2.cvtColor(image, cv2.COLOR_BGR2RGB)
            results = hands.process(image_rgb)
            if not results.multi_hand_landmarks or len(results.multi_hand_landmarks[0].landmark) != 21:
                with open(error_log_path, "a") as ef:
                    ef.write(f"{image_path}: Invalid number of landmarks.\n")
                continue

            h, w, _ = image.shape
            landmarks = results.multi_hand_landmarks[0].landmark
            pts = np.array([[lm.x * w, lm.y * h] for lm in landmarks])
            min_x, max_x = np.min(pts[:, 0]), np.max(pts[:, 0])
            min_y, max_y = np.min(pts[:, 1]), np.max(pts[:, 1])
            bb_width = max_x - min_x if (max_x - min_x) > 1 else 1
            bb_height = max_y - min_y if (max_y - min_y) > 1 else 1
            scale_factor = 0.9 * min(FINAL_W / bb_width, FINAL_H / bb_height)

            bb_center_x = (min_x + max_x) / 2.0
            bb_center_y = (min_y + max_y) / 2.0
            final_center_x = FINAL_W / 2.0
            final_center_y = FINAL_H / 2.0
            transformed_points = []

            for x, y in pts:
                x_trans = (x - bb_center_x) * scale_factor + final_center_x
                y_trans = (y - bb_center_y) * scale_factor + final_center_y
                transformed_points.append((int(x_trans), int(y_trans)))
            skeleton_image = np.zeros((FINAL_H, FINAL_W, 3), dtype=np.uint8)

            for start_idx, end_idx in HAND_CONNECTIONS:
                x1, y1 = transformed_points[start_idx]
                x2, y2 = transformed_points[end_idx]
                cv2.line(skeleton_image, (x1, y1), (x2, y2), (255, 255, 255), 2)
                cv2.circle(skeleton_image, (x1, y1), 4, (0, 0, 255), -1)
                cv2.circle(skeleton_image, (x2, y2), 4, (0, 0, 255), -1)

            handedness_label = None
            if results.multi_handedness:
                handedness_label = results.multi_handedness[0].classification[0].label
            if handedness_label == 'Right':
                skeleton_image = cv2.flip(skeleton_image, 1)
            base_name = os.path.splitext(image_name)[0]
            output_filename = f"{base_name}_base.png"
            out_path = os.path.join(subfolder_output, output_filename)
            cv2.imwrite(out_path, skeleton_image)
            count += 1
        folder_counts[folder_name] = count

    print("Num of image after Skeletons created")
    for folder, cnt in folder_counts.items():
        print(f"Folder {folder}: {cnt} images.")

    for folder_name, count in folder_counts.items():
        folder_dir = os.path.join(output_root, folder_name)
        all_images = [f for f in os.listdir(folder_dir) if f.endswith(".png") and "_aug" not in f]
        augment_counter = 0
        current_count = len(all_images)

        while current_count < target_max_count:
            img_file = random.choice(all_images)
            img_path = os.path.join(folder_dir, img_file)
            image = cv2.imread(img_path)
            if image is None:
                continue
            aug_image = augment_image(image)
            aug_filename = f"{os.path.splitext(img_file)[0]}_aug_{augment_counter}.png"
            cv2.imwrite(os.path.join(folder_dir, aug_filename), aug_image)
            augment_counter += 1
            current_count += 1
        folder_counts[folder_name] = current_count
        print(f"Folder {folder_name} augmented to {current_count} images.")
