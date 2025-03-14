import os
import socket
import threading
from queue import Queue
import json
import time

class GMS2Client:
    client_queue: Queue
    thread: threading.Thread

    def __init__(self):
        self.client_queue = Queue()
        self.host = "127.0.0.1"
        self.port = 36042

    def start_thread(self) -> None:
        self.thread = self.create_thread()
        self.thread.start()

    def create_thread(self) -> threading.Thread:
        server_thread: threading.Thread
        server_thread = threading.Thread(target=self.handle_connection_tcp)
        return server_thread

    def handle_connection_tcp(self) -> bool:
        sock: socket.socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        sock.bind((self.host, self.port))
        print("listening")
        sock.listen()

        try:
            conn: socket.socket
            conn, _ = sock.accept()
        except Exception as e:
            raise e

        with conn:
            self.mainloop(conn)

    def mainloop(self, conn: socket.socket) -> None:
        conn.settimeout(0.1)
        while True:
            latest_data = None
            while not self.client_queue.empty():
                latest_data = self.client_queue.get()
            if latest_data is not None:
                print(f"sending: {latest_data}")
                try:
                    conn.send(bytes(latest_data, encoding="UTF-8"))
                except Exception as e:
                    print(f"Error sending data: {e}")
            time.sleep(0.3)
        return None
