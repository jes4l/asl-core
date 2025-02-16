import cv2
import numpy as np
import mediapipe as mp
from tensorflow.keras.models import load_model

# Load the three different models
model1 = load_model(r'C:\Users\LLR User\Desktop\slcv\saved_models\model1.h5')
model2 = load_model(r'C:\Users\LLR User\Desktop\slcv\saved_models\model2.h5')
model3 = load_model(r'C:\Users\LLR User\Desktop\slcv\saved_models\model3.h5')
models = [model1, model2, model3]

# Define ensemble weights (example weights, adjust as necessary)
weights = [0.4, 0.2, 0.4]

# Define gesture classes (adjust if needed)
class_names = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J',
               'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T',
               'U', 'V', 'W', 'X', 'Y']

# Initialize MediaPipe Hands for hand detection
mp_hands = mp.solutions.hands
hands = mp_hands.Hands(
    static_image_mode=False,
    max_num_hands=1,
    min_detection_confidence=0.7,
    min_tracking_confidence=0.5)

mp_draw = mp.solutions.drawing_utils


def preprocess_image(image):
    """
    Preprocess the image for the CNN:
    - Convert to grayscale if necessary
    - Resize to 28x28
    - Normalize pixel values
    - Reshape to (1, 28, 28, 1)
    """
    # Convert to grayscale (if not already)
    gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
    # Resize to 28x28
    resized = cv2.resize(gray, (28, 28))
    # Normalize the image
    normalized = resized / 255.0
    # Reshape to match model input
    reshaped = normalized.reshape(1, 28, 28, 1)
    return reshaped


# Start capturing from the webcam
cap = cv2.VideoCapture(0)

while True:
    ret, frame = cap.read()
    if not ret:
        break

    # Flip frame for a mirror-like effect (optional)
    frame = cv2.flip(frame, 1)

    # Convert the frame color for MediaPipe (expects RGB)
    rgb_frame = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)

    # Process the frame for hand landmarks
    results = hands.process(rgb_frame)

    if results.multi_hand_landmarks:
        # If a hand is detected, get the bounding box
        for hand_landmarks in results.multi_hand_landmarks:
            # Draw landmarks on the frame
            mp_draw.draw_landmarks(frame, hand_landmarks, mp_hands.HAND_CONNECTIONS)

            # Calculate bounding box from landmarks
            h, w, c = frame.shape
            x_coords = [landmark.x * w for landmark in hand_landmarks.landmark]
            y_coords = [landmark.y * h for landmark in hand_landmarks.landmark]
            x_min, x_max = int(min(x_coords)), int(max(x_coords))
            y_min, y_max = int(min(y_coords)), int(max(y_coords))

            # Add some margin
            margin = 20
            x_min = max(x_min - margin, 0)
            y_min = max(y_min - margin, 0)
            x_max = min(x_max + margin, w)
            y_max = min(y_max + margin, h)

            # Crop the hand region
            hand_roi = frame[y_min:y_max, x_min:x_max]

            if hand_roi.size == 0:
                continue  # Skip if the ROI is invalid

            # Preprocess the hand region to feed into the CNN
            processed_image = preprocess_image(hand_roi)

            # Get predictions from each model
            preds = [model.predict(processed_image) for model in models]
            preds = np.array(preds)

            # Ensemble prediction using weighted average
            weighted_preds = np.tensordot(preds, weights, axes=((0), (0)))
            prediction = np.argmax(weighted_preds, axis=1)[0]
            gesture = class_names[prediction]

            # Draw the predicted gesture on the frame
            cv2.putText(frame, f"Gesture: {gesture}", (x_min, y_min - 10),
                        cv2.FONT_HERSHEY_SIMPLEX, 1, (0, 255, 0), 2)

            # Optionally, draw the bounding box
            cv2.rectangle(frame, (x_min, y_min), (x_max, y_max), (255, 0, 0), 2)

    cv2.imshow("Real-Time Hand Gesture Recognition", frame)

    # Break loop if 'q' is pressed
    if cv2.waitKey(1) & 0xFF == ord('q'):
        break

cap.release()
cv2.destroyAllWindows()
