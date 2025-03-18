import os
import cv2
import mediapipe as mp
import numpy as np
import random

input_root = r"C:\Users\jesal\Downloads\archive\asl_alphabet_train\asl_alphabet_train"
output_root = r"C:\Users\jesal\Downloads\archive"
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
        print(f"Folder {folder_name} processed: {count} images.")

    print("Counts per folder after processing:")
    for folder, cnt in folder_counts.items():
        print(f"Folder {folder}: {cnt} images.")

    min_count = min(folder_counts.values()) if folder_counts else 0
    print(f"Minimum image count among folders: {min_count}")

    for folder_name, count in folder_counts.items():
        folder_dir = os.path.join(output_root, folder_name)
        all_images = [f for f in os.listdir(folder_dir) if f.endswith(".png")]
        if len(all_images) > min_count:
            random.shuffle(all_images)
            to_remove = all_images[min_count:]
            for f in to_remove:
                os.remove(os.path.join(folder_dir, f))
            folder_counts[folder_name] = min_count
            print(f"Folder {folder_name} balanced to {min_count} images by removing {len(to_remove)} images.")

    print("Final counts per folder:")
    for folder, cnt in folder_counts.items():
        print(f"Folder {folder}: {cnt} images.")
