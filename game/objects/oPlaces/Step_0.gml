// oPlaces - Step Event

y += fallSpeed;

// If it leaves the room at bottom, destroy
if (y > room_height + sprite_height) {
    instance_destroy();
}
