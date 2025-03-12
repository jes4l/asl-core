import cv2
import mediapipe as mp
import os
import numpy as np
import tensorflow as tf

MODEL_SAVE_PATH = r'C:\Users\LLR User\Desktop\Project\diss\vision\Model\model.h5'
class_names = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V',
               'W', 'X', 'Y']

FINAL_W, FINAL_H = 200, 200

model = tf.keras.models.load_model(MODEL_SAVE_PATH)

mp_hands = mp.solutions.hands
hands = mp_hands.Hands(
    static_image_mode=False,
    max_num_hands=1,
    min_detection_confidence=0.5
)
mp_drawing = mp.solutions.drawing_utils

HAND_CONNECTIONS = [
    (0, 1), (1, 2), (2, 3), (3, 4),
    (0, 5), (5, 6), (6, 7), (7, 8),
    (5, 9), (9, 10), (10, 11), (11, 12),
    (9, 13), (13, 14), (14, 15), (15, 16),
    (13, 17), (17, 18), (18, 19), (19, 20),
    (0, 17)
]

cap = cv2.VideoCapture(0)
if not cap.isOpened():
    print("Error: Could not open webcam.")
    exit()

while True:
    ret, frame = cap.read()
    if not ret:
        print("Failed to read from camera.")
        break

    frame_rgb = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)
    results = hands.process(frame_rgb)

    annotated_frame = frame.copy()
    predicted_label = None

    if results.multi_hand_landmarks:
        for hand_landmarks in results.multi_hand_landmarks:
            mp_drawing.draw_landmarks(
                annotated_frame,
                hand_landmarks,
                mp_hands.HAND_CONNECTIONS
            )

        skeleton_image = np.zeros((FINAL_H, FINAL_W, 3), dtype=np.uint8)
        h, w, _ = frame.shape

        hand_landmarks = results.multi_hand_landmarks[0].landmark
        handedness_label = None
        if results.multi_handedness:
            handedness_label = results.multi_handedness[0].classification[0].label

        pts = np.array([[lm.x * w, lm.y * h] for lm in hand_landmarks])
        min_x, max_x = np.min(pts[:, 0]), np.max(pts[:, 0])
        min_y, max_y = np.min(pts[:, 1]), np.max(pts[:, 1])
        bb_width = max_x - min_x if max_x - min_x > 1 else 1
        bb_height = max_y - min_y if max_y - min_y > 1 else 1

        scale_factor = 0.9 * min(FINAL_W / bb_width, FINAL_H / bb_height)
        bb_center_x = (min_x + max_x) / 2.0
        bb_center_y = (min_y + max_y) / 2.0
        final_center_x = FINAL_W / 2.0
        final_center_y = FINAL_H / 2.0

        transformed_points = []
        for x, y in pts:
            x = (x - bb_center_x) * scale_factor + final_center_x
            y = (y - bb_center_y) * scale_factor + final_center_y
            transformed_points.append((int(x), int(y)))

        for start_idx, end_idx in HAND_CONNECTIONS:
            x1, y1 = transformed_points[start_idx]
            x2, y2 = transformed_points[end_idx]
            cv2.line(skeleton_image, (x1, y1), (x2, y2), (255, 255, 255), 2)
            cv2.circle(skeleton_image, (x1, y1), 4, (0, 0, 255), -1)
            cv2.circle(skeleton_image, (x2, y2), 4, (0, 0, 255), -1)

        if handedness_label == 'Right':
            skeleton_image = cv2.flip(skeleton_image, 1)

        input_img = np.expand_dims(skeleton_image.astype("float32"), axis=0)

        predictions = model.predict(input_img)
        predicted_index = np.argmax(predictions)
        predicted_label = class_names[predicted_index]
        annotated_frame[0:FINAL_H, 0:FINAL_W] = cv2.addWeighted(
            annotated_frame[0:FINAL_H, 0:FINAL_W], 0.5, skeleton_image, 0.5, 0
        )

    if predicted_label is not None:
        cv2.putText(annotated_frame, f"Gesture: {predicted_label}", (10, 30),
                    cv2.FONT_HERSHEY_SIMPLEX, 1, (0, 255, 0), 2, cv2.LINE_AA)

    cv2.imshow("Gesture Recognition", annotated_frame)
    key = cv2.waitKey(1) & 0xFF
    if key == ord('q'):
        break

cap.release()
hands.close()
cv2.destroyAllWindows()
