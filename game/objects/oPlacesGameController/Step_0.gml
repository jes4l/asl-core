// Step Event
spawnTimer -= 1;

// Spawn a new obstacle if the timer reaches zero
if (spawnTimer <= 0) {
    spawnInterval = irandom_range(spawnIntervalMin, spawnIntervalMax);
    spawnTimer = spawnInterval;

    // Create a new obstacle
    instance_create_layer(0, -sprite_height, "Instances", oObstacle);
}

if (!wordSpawned) {
    wordSpawnTimer -= 1;
    if (wordSpawnTimer <= 0) {
        wordSpawnTimer = room_speed * 15;
        var currentWord = global.wordList[global.currentWordIndex];
        var targetObject = ds_map_find_value(global.wordToObjectMap, currentWord);

        if (!is_undefined(targetObject)) {
            var sectionWidth = room_width div 3;
            var selectedLane = irandom(2);
            var xPos = (sectionWidth div 2) + (selectedLane * sectionWidth);

            instance_create_layer(xPos, -sprite_height, "Instances", targetObject);
            wordSpawned = true;
        }
    }
}