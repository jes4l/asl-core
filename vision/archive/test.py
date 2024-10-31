import cv2
from cvzone.HandTrackingModule import HandDetector
from cvzone.ClassificationModule import Classifier
import numpy as np
import math

cameraCapture = cv2.VideoCapture(0)
handDetector = HandDetector(maxHands=1)
signClassifier = Classifier("Model/keras_model.h5", "Model/labels.txt")
margin = 20
imageSize = 300
signLabels = ["al", "bl", "cl", "dl", "el"]


def cropImageWithBounds(img, x, y, width, height, margin):
    """Crop the region around the hand within image boundaries."""
    yStart, yEnd = max(0, y - margin), min(img.shape[0], y + height + margin)
    xStart, xEnd = max(0, x - margin), min(img.shape[1], x + width + margin)
    croppedImg = img[yStart:yEnd, xStart:xEnd]
    return croppedImg if croppedImg.size != 0 else None


def resizeAndCenterImage(cropImg, targetSize, aspectRatio):
    """Resize and center the cropped image within a white background."""
    centeredImg = np.ones((targetSize, targetSize, 3), np.uint8) * 255

    if aspectRatio > 1:
        # Resize based on height
        scale = targetSize / cropImg.shape[0]
        newWidth = min(math.ceil(scale * cropImg.shape[1]), targetSize)
        resizedImg = cv2.resize(cropImg, (newWidth, targetSize))
        widthGap = (targetSize - newWidth) // 2
        centeredImg[:, widthGap : widthGap + newWidth] = resizedImg
    else:
        # Resize based on width
        scale = targetSize / cropImg.shape[1]
        newHeight = min(math.ceil(scale * cropImg.shape[0]), targetSize)
        resizedImg = cv2.resize(cropImg, (targetSize, newHeight))
        heightGap = (targetSize - newHeight) // 2
        centeredImg[heightGap : heightGap + newHeight, :] = resizedImg

    return centeredImg


while True:
    success, frame = cameraCapture.read()
    if not success:
        print("Failed to capture image")
        continue

    outputFrame = frame.copy()
    hands, frame = handDetector.findHands(frame)

    if hands:
        hand = hands[0]
        x, y, width, height = hand["bbox"]
        croppedHand = cropImageWithBounds(frame, x, y, width, height, margin)

        if croppedHand is not None:
            aspectRatio = height / width
            centeredHand = resizeAndCenterImage(croppedHand, imageSize, aspectRatio)
            prediction, index = signClassifier.getPrediction(centeredHand, draw=False)
            # Display bounding box and label
            cv2.rectangle(
                outputFrame,
                (x - margin, y - margin - 50),
                (x - margin + 90, y - margin - 50 + 50),
                (255, 0, 255),
                cv2.FILLED,
            )
            cv2.putText(
                outputFrame,
                signLabels[index],
                (x, y - 26),
                cv2.FONT_HERSHEY_COMPLEX,
                1.7,
                (255, 255, 255),
                2,
            )
            cv2.rectangle(
                outputFrame,
                (x - margin, y - margin),
                (x + width + margin, y + height + margin),
                (255, 0, 255),
                4,
            )

            cv2.imshow("Cropped Hand", croppedHand)
            cv2.imshow("Centered Hand", centeredHand)

    cv2.imshow("Output", outputFrame)
    cv2.waitKey(1)
