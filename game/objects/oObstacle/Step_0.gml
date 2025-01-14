// oObstacle - Step Event

// Move the obstacle downward
y += fallSpeed;

// If we move out of the room, destroy to save memory
if (y > room_height + sprite_height) {
    instance_destroy();
}
