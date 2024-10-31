import os
import socket
import threading
from queue import Queue
import json
import time


class GMS2Client:
    client_queue: Queue  # Queue to transfer data from the subthread to the main thread.
    thread: threading.Thread  # Client thread to maintain client-server connection.

    def __init__(self):
        """
        Initialises the GMS2Client class.
        - Sets up the client queue for message transmission.
        - Defines the host and port for the server connection.
        """
        self.client_queue = Queue()
        self.host = "127.0.0.1"
        self.port = 36042

    def start_thread(self) -> None:
        """
        Initialises and starts the client thread.
        - Creates the client thread and starts it.
        """
        self.thread = self.create_thread()
        self.thread.start()

    def create_thread(self) -> threading.Thread:
        """
        Creates the client thread.
        - Initialises the thread with the target method `handle_connection_tcp`.

        Returns:
        threading.Thread: The client thread instance.
        """
        server_thread: threading.Thread
        server_thread = threading.Thread(target=self.handle_connection_tcp)
        return server_thread

    def handle_connection_tcp(self) -> bool:
        """
        Initialises the connection to the server and handles message transmission.
        - Sets up a socket and binds it to the specified host and port.
        - Listens for a connection from the server.
        - Manages the connection lifecycle and starts the main loop for communication.

        Returns:
        bool: True if the connection is established successfully.
        """
        # Initialise the socket and bind it to the specified host, at the specified port.
        sock: socket.socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        sock.bind((self.host, self.port))
        print("listening")
        sock.listen()

        # Attempt connection to the server.
        try:
            conn: socket.socket
            conn, _ = sock.accept()
        except Exception as e:
            raise e

        with conn:
            self.mainloop(conn)

    def mainloop(self, conn: socket.socket) -> None:
        """
        Manages the main loop for client-server communication.
        - Sends messages to the GameMaker server if any are queued.
        - Receives messages from the server.
        - Uses a timeout to avoid blocking on receive operations.

        Parameters:
        conn (socket.socket): The connection socket used for communication.
        """
        conn.settimeout(0.1)  # Set a small timeout to avoid blocking on recv
        while True:
            # Send messages if any are queued
            if not self.client_queue.empty():
                data: str = self.client_queue.get()
                print(f"sending: {data}")
                conn.send(bytes(data, encoding="UTF-8"))
            time.sleep(1)
        return None
