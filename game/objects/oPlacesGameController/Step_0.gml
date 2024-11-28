// Decrease the spawn timer
spawnTimer -= 1;

// Spawn a new obstacle if the timer reaches zero
if (spawnTimer <= 0) {
    // Reset the spawn timer with a new random interval
    spawnInterval = irandom_range(spawnIntervalMin, spawnIntervalMax);
    spawnTimer = spawnInterval;

    // Create a new obstacle
    instance_create_layer(0, -sprite_height, "Instances", oObstacle);
}
