import cv2
import mediapipe as mp
import os
import numpy as np
import tensorflow as tf
import json
import time
import threading
from queue import Queue

MODEL_SAVE_PATH = r'C:\Users\jesal\Desktop\Project\diss\vision\Python\EastWestCV\saved_models\model.h5'
class_names = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V',
               'W', 'X', 'Y']
FINAL_W, FINAL_H = 200, 200

class CVHandler:
    def __init__(self):
        self.cap = cv2.VideoCapture(0)
        if not self.cap.isOpened():
            raise Exception("Error: Could not open webcam.")

        self.mp_hands = mp.solutions.hands
        self.hands = self.mp_hands.Hands(
            static_image_mode=False,
            max_num_hands=1,
            min_detection_confidence=0.5
        )
        self.mp_drawing = mp.solutions.drawing_utils
        self.HAND_CONNECTIONS = [
            (0, 1), (1, 2), (2, 3), (3, 4),
            (0, 5), (5, 6), (6, 7), (7, 8),
            (5, 9), (9, 10), (10, 11), (11, 12),
            (9, 13), (13, 14), (14, 15), (15, 16),
            (13, 17), (17, 18), (18, 19), (19, 20),
            (0, 17)
        ]
        self.FINAL_W = FINAL_W
        self.FINAL_H = FINAL_H
        self.class_names = class_names
        self.model = tf.keras.models.load_model(MODEL_SAVE_PATH)

        self.stable_sign = None
        self.stable_count = 0
        self.stable_threshold = 3
        self.last_sign_time = time.time()
        self.debounce_interval = 0.5

        self.last_display_time = time.time()
        self.display_interval = 0.1

    def get_sign(self):
        ret, frame = self.cap.read()
        if not ret:
            print("Failed to read from camera.")
            return None, None, -1, -1
        h, w, _ = frame.shape
        frame_rgb = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)
        results = self.hands.process(frame_rgb)
        predicted_label = None
        confidence = None
        center_x, center_y = -1, -1
        annotated_frame = frame.copy()

        if results.multi_hand_landmarks:
            hand_landmarks = results.multi_hand_landmarks[0]
            self.mp_drawing.draw_landmarks(
                annotated_frame,
                hand_landmarks,
                self.mp_hands.HAND_CONNECTIONS
            )

            skeleton_image = np.zeros((self.FINAL_H, self.FINAL_W, 3), dtype=np.uint8)
            pts = np.array([[lm.x * w, lm.y * h] for lm in hand_landmarks.landmark])
            min_x, max_x = np.min(pts[:, 0]), np.max(pts[:, 0])
            min_y, max_y = np.min(pts[:, 1]), np.max(pts[:, 1])
            bb_width = max_x - min_x if max_x - min_x > 1 else 1
            bb_height = max_y - min_y if max_y - min_y > 1 else 1

            scale_factor = 0.9 * min(self.FINAL_W / bb_width, self.FINAL_H / bb_height)
            bb_center_x = (min_x + max_x) / 2.0
            bb_center_y = (min_y + max_y) / 2.0
            final_center_x = self.FINAL_W / 2.0
            final_center_y = self.FINAL_H / 2.0

            transformed_points = []
            for x, y in pts:
                new_x = (x - bb_center_x) * scale_factor + final_center_x
                new_y = (y - bb_center_y) * scale_factor + final_center_y
                transformed_points.append((int(new_x), int(new_y)))

            for start_idx, end_idx in self.HAND_CONNECTIONS:
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

            input_img = np.expand_dims(skeleton_image.astype("float32"), axis=0)
            predictions = self.model.predict(input_img)
            predicted_index = np.argmax(predictions)
            predicted_label = self.class_names[predicted_index]
            confidence = predictions[0][predicted_index]

            center_x = int(np.mean(pts[:, 0]))
            center_y = int(np.mean(pts[:, 1]))

            overlay = cv2.addWeighted(
                annotated_frame[0:self.FINAL_H, 0:self.FINAL_W],
                0.5,
                skeleton_image,
                0.5,
                0
            )
            annotated_frame[0:self.FINAL_H, 0:self.FINAL_W] = overlay
            cv2.putText(
                annotated_frame, f"Gesture: {predicted_label}", (10, 30),
                cv2.FONT_HERSHEY_SIMPLEX, 1, (0, 255, 0), 2, cv2.LINE_AA
            )

        current_time = time.time()
        if current_time - self.last_display_time >= self.display_interval:
            cv2.imshow("Gesture Recognition", annotated_frame)
            cv2.waitKey(1)
            self.last_display_time = current_time

        return predicted_label, confidence, center_x, center_y

    def send_messages(self, queue: Queue) -> None:
        while True:
            sign, confidence, x, y = self.get_sign()
            if x == -1 and y == -1:
                time.sleep(0.3)
                continue

            message = {"pos": [x, y]}

            if sign is not None:
                if sign == self.stable_sign:
                    self.stable_count += 1
                else:
                    self.stable_sign = sign
                    self.stable_count = 1

                if self.stable_count >= self.stable_threshold:
                    message["data"] = sign
                    message["confidence"] = float(confidence)
                    self.stable_count = 0

            message_json = json.dumps(message)
            queue.put(message_json)
            print(f"putting {message_json}")
            time.sleep(0.3)

    def __del__(self):
        self.cap.release()
        self.hands.close()
        cv2.destroyAllWindows()