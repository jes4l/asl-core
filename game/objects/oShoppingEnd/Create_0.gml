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
var correctWords = [];
if (variable_global_exists("activeWords") && global.activeWords != undefined) {
    for (var i = 0; i < array_length_1d(global.activeWords); i++) {
        if (!variable_global_exists("incorrectWords") || ds_list_find_index(global.incorrectWords, global.activeWords[i]) == -1) {
            array_push(correctWords, global.activeWords[i]);
        }
    }
}
numBagsToSpawn = array_length_1d(correctWords);
global.correctWords = correctWords;
