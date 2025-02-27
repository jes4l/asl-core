import cv2
import mediapipe as mp
import os
import numpy as np
from datetime import datetime

output_dir = r"C:\Users\LLR User\Downloads\pointnet_hands-main\pointnet_hands-main\results\captures"
output_with_bg = os.path.join(output_dir, "with_bg")
output_skeleton_only = os.path.join(output_dir, "skeleton")
os.makedirs(output_with_bg, exist_ok=True)
os.makedirs(output_skeleton_only, exist_ok=True)

FINAL_W, FINAL_H = 200, 200

mp_hands = mp.solutions.hands
hands = mp_hands.Hands(
    static_image_mode=False,
    max_num_hands=1,
    min_detection_confidence=0.5
)
mp_drawing = mp.solutions.drawing_utils

HAND_CONNECTIONS = [
    (0,1), (1,2), (2,3), (3,4),
    (0,5), (5,6), (6,7), (7,8),
    (5,9), (9,10), (10,11), (11,12),
    (9,13), (13,14), (14,15), (15,16),
    (13,17), (17,18), (18,19), (19,20),
    (0,17)
]

cap = cv2.VideoCapture(0)
if not cap.isOpened():
    print("Error: Could not open webcam.")
    exit()

capture_count = 0

while True:
    ret, frame = cap.read()
    if not ret:
        print("Failed to read from camera.")
        break

    frame_rgb = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)
    results = hands.process(frame_rgb)

    annotated_frame = frame.copy()
    if results.multi_hand_landmarks:
        for hand_landmarks in results.multi_hand_landmarks:
            mp_drawing.draw_landmarks(
                annotated_frame,
                hand_landmarks,
                mp_hands.HAND_CONNECTIONS
            )

    cv2.imshow("Data Collection", annotated_frame)

    key = cv2.waitKey(1) & 0xFF
    if key == ord('q'):
        break
    elif key == ord('c'):
        skeleton_image_200 = np.zeros((FINAL_H, FINAL_W, 3), dtype=np.uint8)
        h, w, _ = frame.shape

        if results.multi_hand_landmarks:
            hand_landmarks = results.multi_hand_landmarks[0].landmark
            handedness_label = None
            if results.multi_handedness:
                handedness_label = results.multi_handedness[0].classification[0].label

            pts = np.array([[lm.x * w, lm.y * h] for lm in hand_landmarks])
            min_x = np.min(pts[:, 0])
            max_x = np.max(pts[:, 0])
            min_y = np.min(pts[:, 1])
            max_y = np.max(pts[:, 1])
            bb_width = max_x - min_x
            bb_height = max_y - min_y
            if bb_width < 1:
                bb_width = 1
            if bb_height < 1:
                bb_height = 1
            scale_factor = 0.9 * min(FINAL_W / bb_width, FINAL_H / bb_height)
            bb_center_x = (min_x + max_x) / 2.0
            bb_center_y = (min_y + max_y) / 2.0
            final_center_x = FINAL_W / 2.0
            final_center_y = FINAL_H / 2.0

            transformed_points = []
            for x, y in pts:
                x -= bb_center_x
                y -= bb_center_y
                x *= scale_factor
                y *= scale_factor
                x += final_center_x
                y += final_center_y
                transformed_points.append((int(x), int(y)))

            for start_idx, end_idx in HAND_CONNECTIONS:
                x1, y1 = transformed_points[start_idx]
                x2, y2 = transformed_points[end_idx]
                cv2.line(skeleton_image_200, (x1, y1), (x2, y2), (255, 255, 255), 2)
                cv2.circle(skeleton_image_200, (x1, y1), 4, (0, 0, 255), -1)
                cv2.circle(skeleton_image_200, (x2, y2), 4, (0, 0, 255), -1)

            if handedness_label == 'Right':
                skeleton_image_200 = cv2.flip(skeleton_image_200, 1)

        timestamp = datetime.now().strftime("%Y%m%d_%H%M%S_%f")
        bg_filename = f"capture_{capture_count}_bg.jpg"
        skel_filename = f"capture_{capture_count}_skel.jpg"

        cv2.imwrite(os.path.join(output_with_bg, bg_filename), annotated_frame)
        cv2.imwrite(os.path.join(output_skeleton_only, skel_filename), skeleton_image_200)

        print(f"[INFO] Captured images #{capture_count}:")
        print(f"  - {bg_filename}")
        print(f"  - {skel_filename}")

        capture_count += 1

cap.release()
hands.close()
cv2.destroyAllWindows()
