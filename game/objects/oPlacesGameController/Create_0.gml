// Create Event
spawnTimer = 0;

// Adjust the spawn interval for obstacles
spawnIntervalMin = room_speed * 6; // 6 seconds
spawnIntervalMax = room_speed * 8; // 8 seconds
spawnInterval = irandom_range(spawnIntervalMin, spawnIntervalMax);

// Timer for spawning the currentWord object
wordSpawnTimer = room_speed * 15; // 15 seconds
wordSpawned = false; // Ensure the word object is spawned only once

if (!variable_global_exists("wordToObjectMap")) {
    global.wordToObjectMap = ds_map_create();
    ds_map_add(global.wordToObjectMap, "acb", oCinema);
    ds_map_add(global.wordToObjectMap, "bca", oShop);
    ds_map_add(global.wordToObjectMap, "cab", oHospital);
}
