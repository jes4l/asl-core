// Timer for spawning obstacles
spawnTimer = 0;

// Adjust the spawn interval to ensure a minimum of 5 seconds
spawnIntervalMin = 480; // 8 seconds
spawnIntervalMax = 540; // 6 seconds
spawnInterval = irandom_range(spawnIntervalMin, spawnIntervalMax);


if (!variable_global_exists("wordToObjectMap")) {
    global.wordToObjectMap = ds_map_create();
    ds_map_add(global.wordToObjectMap, "acb", oCinema);
    ds_map_add(global.wordToObjectMap, "bca", oShop);
	ds_map_add(global.wordToObjectMap, "cab", oBuilding);
}
