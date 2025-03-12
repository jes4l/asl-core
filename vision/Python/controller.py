from Python.cv_client import GMS2Client
from Python.computer_vision_here import CVHandler
from queue import Queue


class MessageController:
    client: GMS2Client
    client_queue: Queue
    gesture_queue: (
        Queue
    )

    def __init__(self) -> None:
        self.create_client()
        self.init_cv()
        self.most_recent_msg = {}
        self.last_transmit_time = 0.0

    def create_client(self) -> None:
        self.client = GMS2Client()
        self.client_queue: Queue = self.client.client_queue
        self.client.start_thread()

    def init_cv(self) -> None:
        self.gesture_recognizer = CVHandler()
        self.gesture_recognizer.send_messages(self.client_queue)

    def mainloop(self) -> None:
        while True:
            self.update_client()


    def update_client(self) -> None:
        try:
            self.try_transmit_to_client()
        except Exception as e:
            raise e

    def try_transmit_to_client(self) -> bool:
        if not self.message_queue.empty():
            messages: str = self.message_queue.get()
            self.client_queue.put(messages)
            return True
        else:
            return False

