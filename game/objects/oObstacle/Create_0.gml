if (!variable_global_exists("obstacleSequence")) {
    global.obstacleSequence = 0;
}

if (global.obstacleSequence mod 2 == 0) { 
    var signNames = ["Library", "Cinema", "Hospital", "Park", "Museum", "School"];
    if (is_array(global.activeWords) && array_length_1d(global.activeWords) > 0) {
        var activeWord = global.activeWords[0];
        for (var i = array_length_1d(signNames) - 1; i >= 0; i--) {
            if (signNames[i] == activeWord) {
                array_delete(signNames, i, 1);
            }
        }
    }
    
    var chosenSign = signNames[irandom(array_length_1d(signNames) - 1)];
    sprite_index = scrGetWordPoolSprite(chosenSign);
} else { 
    var obstacleIndex = ((global.obstacleSequence - 1) div 2) mod 3;
    var sprites = [sObstacle0, sObstacle1, sObstacle2];
    sprite_index = sprites[obstacleIndex];
}

global.obstacleSequence++;
fallSpeed = 5;