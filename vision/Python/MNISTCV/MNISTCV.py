import cv2
import mediapipe as mp
import numpy as np
from keras.models import load_model

mp_hands = mp.solutions.hands
hands = mp_hands.Hands(max_num_hands=1, min_detection_confidence=0.7, min_tracking_confidence=0.5)
mp_draw = mp.solutions.drawing_utils

models = [
    load_model('saved_models/model1.hdf5'),
    load_model('saved_models/model2.hdf5'),
    load_model('saved_models/model3.hdf5')
]
class_names = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I',
               'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S',
               'T', 'U', 'V', 'W', 'X', 'Y']

ensemble_weights = [0.4, 0.1, 0.2]

def preprocess_roi(image):
    gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
    gray = cv2.GaussianBlur(gray, (3, 3), 0)
    gray = cv2.resize(gray, (28, 28))
    processed = gray.astype('float32') / 255.0
    return processed.reshape(1, 28, 28, 1), gray

def get_dynamic_roi(image, landmarks):
    x_coords = [landmark.x * image.shape[1] for landmark in landmarks.landmark]
    y_coords = [landmark.y * image.shape[0] for landmark in landmarks.landmark]
    padding = 30
    min_x, max_x = int(min(x_coords)), int(max(x_coords))
    min_y, max_y = int(min(y_coords)), int(max(y_coords))
    width = max_x - min_x
    height = max_y - min_y
    size = max(width, height) + 2 * padding
    center_x = (min_x + max_x) // 2
    center_y = (min_y + max_y) // 2
    min_x = max(0, center_x - size // 2)
    max_x = min(image.shape[1], center_x + size // 2)
    min_y = max(0, center_y - size // 2)
    max_y = min(image.shape[0], center_y + size // 2)
    return image[min_y:max_y, min_x:max_x], (min_x, min_y, max_x, max_y)

def predict_gesture(roi):
    individual_preds = [model.predict(roi)[0] for model in models]
    weighted_ensemble = np.average(individual_preds, axis=0, weights=ensemble_weights)
    return individual_preds, weighted_ensemble

cap = cv2.VideoCapture(0)

while cap.isOpened():
    ret, frame = cap.read()
    if not ret:
        continue
    frame = cv2.flip(frame, 1)
    rgb_frame = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)
    results = hands.process(rgb_frame)
    roi_image = None
    if results.multi_hand_landmarks:
        for hand_landmarks in results.multi_hand_landmarks:
            roi, (x1, y1, x2, y2) = get_dynamic_roi(frame, hand_landmarks)
            if roi.size > 0:
                processed_roi, gray_display = preprocess_roi(roi)
                model_preds, ensemble_pred = predict_gesture(processed_roi)
                ensemble_class = np.argmax(ensemble_pred)
                model_classes = [np.argmax(pred) for pred in model_preds]
                cv2.rectangle(frame, (x1, y1), (x2, y2), (0, 255, 0), 2)
                y_pos = 30
                colors = [(0, 255, 0), (0, 165, 255), (255, 0, 0)]
                for i, (pred, cls) in enumerate(zip(model_preds, model_classes)):
                    confidence = pred[cls]
                    text = f"Model {i + 1}: {class_names[cls]} ({confidence:.2f})"
                    cv2.putText(frame, text, (10, y_pos), cv2.FONT_HERSHEY_SIMPLEX, 0.7, colors[i], 2)
                    y_pos += 30
                ensemble_conf = ensemble_pred[ensemble_class]
                text = f"Ensemble: {class_names[ensemble_class]} ({ensemble_conf:.2f})"
                cv2.putText(frame, text, (10, y_pos), cv2.FONT_HERSHEY_SIMPLEX, 0.7, (0, 255, 255), 2)
                mp_draw.draw_landmarks(frame, hand_landmarks, mp_hands.HAND_CONNECTIONS)
                gray_display = cv2.resize(gray_display, (280, 280))
                cv2.imshow('Grayscale ROI Input', gray_display)
    cv2.imshow('Sign Language Recognition', frame)
    if cv2.waitKey(10) & 0xFF == ord('q'):
        break

cap.release()
cv2.destroyAllWindows()
