if (!instance_exists(line1)) {
    line1 = instance_create_layer(xPos1, spawnY, "Instances", oLine);
} else {
    if (line1.y + lineHeight >= spawnThresholdY) {
        line1 = instance_create_layer(xPos1, spawnY, "Instances", oLine);
    }
}

if (!instance_exists(line2)) {
    line2 = instance_create_layer(xPos2, spawnY, "Instances", oLine);
} else {
    if (line2.y + lineHeight >= spawnThresholdY) {
        line2 = instance_create_layer(xPos2, spawnY, "Instances", oLine);
    }
}