import tensorflow as tf
import time
from queue import Queue
import threading
import json
import cv2
from cvzone.HandTrackingModule import HandDetector
from cvzone.ClassificationModule import Classifier
import numpy as np
import math


class CVHandler:
    stop_event: threading.Event
    message_queue: (
        Queue
    )
    thread: (
        threading.Thread
    )

    def __init__(self):
        self.message_queue = Queue()
        self.message = {}
        self.cap = cv2.VideoCapture(0)
        self.cap.set(cv2.CAP_PROP_FPS, 30)
        self.detector = HandDetector(maxHands=1)
        self.classifier = Classifier("Model/keras_model.h5", "Model/labels.txt")
        self.margin = 20
        self.imgSize = 300
        self.labels = ["a", "b", "c", "d", "e"]
        self.stable_sign = None
        self.stable_count = 0
        self.stable_threshold = 3
        self.recent_signs = []
        self.sign_window_size = 3
        self.last_sign_time = time.time()
        self.debounce_interval = 0.5

    def send_messages(self, queue) -> None:
        previous_sign = None
        while True:
            sign, x, y = self.get_sign()
            if sign is None:
                continue

            if sign == self.stable_sign:
                self.stable_count += 1
            else:
                self.stable_sign = sign
                self.stable_count = 1

            if self.stable_count >= self.stable_threshold:
                self.stable_count = 0
                most_common_sign = sign
                self.message = {}
                self.message["data"] = self.labels[most_common_sign]
                self.message["pos"] = [x, y]

                message_json = json.dumps(self.message)
                queue.put(message_json)
                print(f"putting {message_json}")

            time.sleep(0.3)

    def cropImageWithBounds(self, img, x, y, width, height, margin):
        yStart, yEnd = max(0, y - margin), min(img.shape[0], y + height + margin)
        xStart, xEnd = max(0, x - margin), min(img.shape[1], x + width + margin)
        croppedImg = img[yStart:yEnd, xStart:xEnd]
        return croppedImg if croppedImg.size != 0 else None

    def resizeAndCenterImage(self, cropImg, targetSize, aspectRatio):
        centeredImg = np.ones((targetSize, targetSize, 3), np.uint8) * 255
        if aspectRatio > 1:
            scale = targetSize / cropImg.shape[0]
            newWidth = min(math.ceil(scale * cropImg.shape[1]), targetSize)
            resizedImg = cv2.resize(cropImg, (newWidth, targetSize))
            widthGap = (targetSize - newWidth) // 2
            centeredImg[:, widthGap : widthGap + newWidth] = resizedImg
        else:
            scale = targetSize / cropImg.shape[1]
            newHeight = min(math.ceil(scale * cropImg.shape[0]), targetSize)
            resizedImg = cv2.resize(cropImg, (targetSize, newHeight))
            heightGap = (targetSize - newHeight) // 2
            centeredImg[heightGap : heightGap + newHeight, :] = resizedImg
        return centeredImg

    def get_sign(self) -> int:
        success, img = self.cap.read()
        if not success:
            print("Failed to capture image")
            return None, -1, -1

        imgOutput = img.copy()
        hands, img = self.detector.findHands(img)

        if hands:
            hand = hands[0]
            x, y, w, h = hand["bbox"]
            croppedHand = self.cropImageWithBounds(img, x, y, w, h, self.margin)

            if croppedHand is not None:
                aspectRatio = h / w
                centeredHand = self.resizeAndCenterImage(
                    croppedHand, self.imgSize, aspectRatio
                )
                prediction, index = self.classifier.getPrediction(
                    centeredHand, draw=False
                )
                cv2.rectangle(
                    imgOutput,
                    (x - self.margin, y - self.margin - 50),
                    (x - self.margin + 90, y - self.margin - 50 + 50),
                    (255, 0, 255),
                    cv2.FILLED,
                )
                cv2.putText(
                    imgOutput,
                    self.labels[index],
                    (x, y - 26),
                    cv2.FONT_HERSHEY_COMPLEX,
                    1.7,
                    (255, 255, 255),
                    2,
                )
                cv2.rectangle(
                    imgOutput,
                    (x - self.margin, y - self.margin),
                    (x + w + self.margin, y + h + self.margin),
                    (255, 0, 255),
                    4,
                )
                # cv2.imshow("Cropped Hand", croppedHand)
                # cv2.imshow("Centered Hand", centeredHand)
                # cv2.imshow("Image", imgOutput)
                # cv2.waitKey(1)
                return index, x + (w // 2), y + (h // 2)

        # cv2.imshow("Image", imgOutput)
        cv2.waitKey(1)
        return None, -1, -1
