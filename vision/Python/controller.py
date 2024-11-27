from Python.cv_client import GMS2Client
from Python.computer_vision_here import CVHandler
from queue import Queue


class MessageController:
    client: GMS2Client  # An instance of the cv_client.Client object (communicates to GMS2 server)
    client_queue: Queue  # An instance of the client queue. Facilitates sending gesture data to the client object.
    gesture_queue: (
        Queue  # An instance of the CV queue. Allows transmission of data to the client.
    )

    def __init__(self) -> None:
        """
        Initialise the MessageController class.
        - Creates and starts the client thread for communication with the GameMaker server.
        - Initialises the gesture recognition thread.
        """
        self.create_client()
        self.init_cv()
        self.most_recent_msg = {}
        self.last_transmit_time = 0.0  # Timestamp of the last transmission

    def create_client(self) -> None:
        """
        Creates and starts a thread that initialises the client.
        - Sets up the client for communication with the GameMaker server.
        - Initialises the client queue for message transmission.
        """
        self.client = GMS2Client()
        self.client_queue: Queue = self.client.client_queue
        self.client.start_thread()

    def init_cv(self) -> None:
        """
        Creates a thread that initialises gesture recognition.
        - Sets up the CVHandler for detecting and classifying hand gestures.
        - Starts the gesture recognition and message sending process.
        """
        self.gesture_recognizer = CVHandler()
        # self.message_queue: Queue = self.gesture_recognizer.message_queue
        # self.gesture_recognizer.start_thread()
        self.gesture_recognizer.send_messages(self.client_queue)

    def mainloop(self) -> None:
        """
        The main loop of the program.
        - Continuously retrieves gesture detections and sends them to the GameMaker server.
        - Calls the update_client method in an infinite loop to ensure constant communication.
        """
        while True:
            self.update_client()


    def update_client(self) -> None:
        """
        Attempts to update the client by transmitting the latest gesture data.
        - Calls the try_transmit_to_client method to send the most recent gesture data from the gesture queue.
        """
        try:
            self.try_transmit_to_client()
        except Exception as e:
            raise e

    def try_transmit_to_client(self) -> bool:
        """
        Attempts to send the most recent gesture from the gesture queue to the GameMaker server.
        - Checks if there are any messages in the gesture queue.
        - Sends the message to the client queue if available.

        Returns:
        bool: True if a message was successfully sent, False otherwise.
        """
        if not self.message_queue.empty():
            messages: str = self.message_queue.get()
            self.client_queue.put(messages)
            return True
        else:
            return False

