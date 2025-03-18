import os
import cv2
import mediapipe as mp
import numpy as np
import random

input_root = r"C:\Users\jesal\Downloads\archive\asl_alphabet_train\asl_alphabet_train"
output_root = r"C:\Users\jesal\Downloads\archive\asl_alphabet_train"
error_log_path = os.path.join(output_root, "errors.txt")
FINAL_W, FINAL_H = 200, 200
TARGET_COUNT = 3000

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

def rotate_image(image, angle):
    center = (FINAL_W // 2, FINAL_H // 2)
    M = cv2.getRotationMatrix2D(center, angle, 1.0)
    return cv2.warpAffine(image, M, (FINAL_W, FINAL_H))


def translate_image(image, x_offset, y_offset):
    M = np.float32([[1, 0, x_offset], [0, 1, y_offset]])
    return cv2.warpAffine(image, M, (FINAL_W, FINAL_H))


aug_methods = [
    ("rot15", lambda img: rotate_image(img, 15)),
    ("rot-15", lambda img: rotate_image(img, -15)),
    ("trans+10", lambda img: translate_image(img, 10, 10)),
    ("trans-10", lambda img: translate_image(img, -10, -10))
]

folder_counts = {}

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
        print(f"Folder {folder_name} processed: {count} base images.")

for folder_name, base_count in folder_counts.items():
    folder_dir = os.path.join(output_root, folder_name)
    # Get list of base images (files ending with '_base.png')
    base_images = [f for f in os.listdir(folder_dir) if f.endswith("_base.png")]
    current_count = len([f for f in os.listdir(folder_dir) if f.endswith(".png")])
    aug_index = 0

    while current_count < TARGET_COUNT:
        base_img_filename = random.choice(base_images)
        base_img_path = os.path.join(folder_dir, base_img_filename)
        base_img = cv2.imread(base_img_path)
        if base_img is None:
            continue

        aug_name, aug_func = random.choice(aug_methods)
        aug_img = aug_func(base_img)

        new_filename = f"{os.path.splitext(base_img_filename)[0]}_aug{aug_index}_{aug_name}.png"
        new_path = os.path.join(folder_dir, new_filename)
        cv2.imwrite(new_path, aug_img)
        current_count += 1
        aug_index += 1

    folder_counts[folder_name] = current_count
    print(f"Folder {folder_name} now has {current_count} images after augmentation.")

print("Final counts per folder:")
for folder, cnt in folder_counts.items():
    print(f"Folder {folder}: {cnt} images.")
