if (irandom(1) == 0) {
    sprite_index = choose(sObstacle0, sObstacle1, sObstacle2);
} else {
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
}

fallSpeed = 5;
