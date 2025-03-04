bagStartX = 0;
bagStartY = 744;
bagEndX = 1488;
bagEndY = 744;
spawnDelay = room_speed * 1.5;
spawnTimer = spawnDelay;
bagSpeed = 0.0025;
allBagsStopped = false;
bagList = ds_list_create();
bag2List = ds_list_create();
if (variable_global_exists("activeWords") && global.activeWords != undefined) {
    numBagsToSpawn = array_length_1d(global.activeWords);
} else {
    numBagsToSpawn = 0;
}
