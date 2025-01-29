// oLineSpawner - Step Event

// Column 1
if (!instance_exists(line1)) {
    // If no line exists, spawn one immediately
    line1 = instance_create_layer(xPos1, spawnY, "Instances", oLine);
} else {
    // Check if the bottom of the line is approaching the threshold
    if (line1.y + sprite_get_height(sLine) >= spawnThresholdY) {
        // Spawn a new line at the top
        line1 = instance_create_layer(xPos1, spawnY, "Instances", oLine);
    }
}

// Column 2
if (!instance_exists(line2)) {
    line2 = instance_create_layer(xPos2, spawnY, "Instances", oLine);
} else {
    if (line2.y + sprite_get_height(sLine) >= spawnThresholdY) {
        line2 = instance_create_layer(xPos2, spawnY, "Instances", oLine);
    }
}