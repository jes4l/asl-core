// Move the object straight down
y += verticalSpeed;

// Destroy the object if it moves out of the room
if (y > room_height) {
    instance_destroy();
}
