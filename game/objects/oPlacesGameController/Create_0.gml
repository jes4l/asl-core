spawnTimer = 0;

spawnIntervalMin = room_speed * 9;
spawnIntervalMax = room_speed * 10;
spawnInterval = irandom_range(spawnIntervalMin, spawnIntervalMax);

wordSpawnTimer = room_speed * 20;
wordSpawned = false;

if (!variable_global_exists("wordToObjectMap")) {
    global.wordToObjectMap = ds_map_create();
    ds_map_add(global.wordToObjectMap, "acb", oCinema);
    ds_map_add(global.wordToObjectMap, "bca", oShop);
    ds_map_add(global.wordToObjectMap, "cab", oHospital);
}
