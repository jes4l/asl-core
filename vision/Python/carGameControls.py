import cv2
import numpy as np
import mediapipe as mp
import time


def drawRegions(img, width, height):
    regions = [
        {"name": "LEFT", "rect": (0, 0, int(width / 2), int(height / 2))},
        {"name": "RIGHT", "rect": (int(width / 2), 0, width, int(height / 2))},
        {
            "name": "ACCELERATE",
            "rect": (
                int(width * 0.25),
                int(height / 2),
                int(width * 0.75),
                int(height * 0.75),
            ),
        },
        {"name": "BRAKE", "rect": (0, int(height * 0.75), width, height)},
    ]
    for region in regions:
        x1, y1, x2, y2 = region["rect"]
        regionWidth, regionHeight = x2 - x1, y2 - y1

        cv2.rectangle(img, (x1, y1), (x2, y2), (255, 0, 0), 2)

        text = region["name"]
        textSize = cv2.getTextSize(text, cv2.FONT_HERSHEY_SIMPLEX, 1.5, 2)[0]
        textWidth, textHeight = textSize
        textX = x1 + (regionWidth - textWidth) // 2
        textY = y1 + (regionHeight + textHeight) // 2

        cv2.putText(
            img, text, (textX, textY), cv2.FONT_HERSHEY_SIMPLEX, 1.5, (255, 255, 255), 2
        )


def detectHandPosition(indexX, indexY, width, height):
    if 0 <= indexX < int(width / 2) and 0 <= indexY < int(height / 2):
        return "LEFT"
    elif int(width / 2) <= indexX < width and 0 <= indexY < int(height / 2):
        return "RIGHT"
    elif int(width * 0.25) <= indexX < int(width * 0.75) and int(
        height / 2
    ) <= indexY < int(height * 0.75):
        return "ACCELERATE"
    elif 0 <= indexX < width and int(height * 0.75) <= indexY < height:
        return "BRAKE"
    return None


def processHandActions(handData, lastActionTime, debounceInterval, width, height):
    actions = set()
    for handLabel, (indexX, indexY) in handData.items():
        indexRegion = detectHandPosition(indexX, indexY, width, height)
        if indexRegion:
            actions.add(indexRegion)

    currentTime = time.time()
    if currentTime - lastActionTime > debounceInterval:
        if "ACCELERATE" in actions and "LEFT" in actions:
            print("ACCELERATE and LEFT")
        elif "ACCELERATE" in actions and "RIGHT" in actions:
            print("ACCELERATE and RIGHT")
        elif "BRAKE" in actions and "LEFT" in actions:
            print("BRAKE and LEFT")
        elif "BRAKE" in actions and "RIGHT" in actions:
            print("BRAKE and RIGHT")
        elif "ACCELERATE" in actions:
            print("ACCELERATE")
        elif "BRAKE" in actions:
            print("BRAKE")
        elif "LEFT" in actions:
            print("LEFT")
        elif "RIGHT" in actions:
            print("RIGHT")
        return currentTime
    return lastActionTime


mpHands = mp.solutions.hands
hands = mpHands.Hands(
    static_image_mode=False,
    max_num_hands=2,
    min_detection_confidence=0.5,
    min_tracking_confidence=0.5,
)

cap = cv2.VideoCapture(0)

lastActionTime = time.time()
debounceInterval = 0.3

while True:
    ret, frame = cap.read()
    if not ret:
        break

    height, width, _ = frame.shape
    img = cv2.flip(frame, 1)
    rgbImg = cv2.cvtColor(img, cv2.COLOR_BGR2RGB)
    result = hands.process(rgbImg)
    drawRegions(img, width, height)

    handData = {}
    if result.multi_hand_landmarks:
        for handIdx, handLandmarks in enumerate(result.multi_hand_landmarks):
            handLabel = result.multi_handedness[handIdx].classification[0].label

            indexTip = handLandmarks.landmark[8]
            indexX, indexY = int(indexTip.x * width), int(indexTip.y * height)
            cv2.circle(img, (indexX, indexY), 10, (0, 255, 0), -1)
            handData[handLabel] = (indexX, indexY)

    lastActionTime = processHandActions(
        handData, lastActionTime, debounceInterval, width, height
    )

    cv2.imshow("Hand Tracking", img)
    if cv2.waitKey(1) & 0xFF == ord("q"):
        break

cap.release()
cv2.destroyAllWindows()
hands.close()