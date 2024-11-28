// Move the obstacle straight down
y += obstacleSpeed;

// Destroy the obstacle if it moves out of the room
if (y > room_height) {
    instance_destroy();
}
