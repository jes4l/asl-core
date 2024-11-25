// Get the target object for the current word
var currentWord = global.wordList[global.currentWordIndex];
var currentObject = ds_map_find_value(global.wordToObjectMap, currentWord);

// Determine the next word
var nextWord = "";
if (global.currentWordIndex + 1 < array_length_1d(global.wordList)) {
    nextWord = global.wordList[global.currentWordIndex + 1];
}
var nextObject = !is_undefined(nextWord) ? ds_map_find_value(global.wordToObjectMap, nextWord) : undefined;

// Check the countdown timer
if (instance_exists(oClock)) {
    with (oClock) {
        if (timerCurrent <= 0) {
            room_goto(rmRoleEnd);
        }
    }
}

// Clean up non-target objects
var key = ds_map_find_first(global.wordToObjectMap);
while (!is_undefined(key)) {
    var obj = ds_map_find_value(global.wordToObjectMap, key);

    // Destroy instances not corresponding to the current or next object
    if (obj != currentObject && obj != nextObject) {
        with (obj) instance_destroy();
    }

    key = ds_map_find_next(global.wordToObjectMap, key);
}

// Handle the current object at the end of the path (normalised position 1)
if (!is_undefined(currentObject)) {
    var endPositionX = path_get_x(ShoppingGamePath, 1);
    var endPositionY = path_get_y(ShoppingGamePath, 1);

    if (!instance_exists(currentObject)) {
        var instanceCurrent = instance_create_layer(endPositionX, endPositionY, "Instances", currentObject);
        instanceCurrent.image_xscale = 1;
        instanceCurrent.image_yscale = 1;
        instanceCurrent.depth = -100;
    } else {
        with (currentObject) {
            x = endPositionX;
            y = endPositionY;
        }
    }
}

// Handle the next object at the middle of the path (normalised position 0.5)
if (!is_undefined(nextObject)) {
    var midPositionX = path_get_x(ShoppingGamePath, 0.5);
    var midPositionY = path_get_y(ShoppingGamePath, 0.5);

    if (!instance_exists(nextObject)) {
        var instanceNext = instance_create_layer(midPositionX, midPositionY, "Instances", nextObject);
        instanceNext.image_xscale = 1;
        instanceNext.image_yscale = 1;
        instanceNext.depth = -100;
    } else {
        with (nextObject) {
            x = midPositionX;
            y = midPositionY;
        }
    }
}

// Reset the countdown when the current word changes
if (currentWord != previousWord) {
    if (instance_exists(oClock)) {
        show_debug_message("oClock exists");
        with (oClock) {
            show_debug_message("Resetting timer to " + string(timerDuration));
            timerCurrent = timerDuration;
        }
    } else {
        show_debug_message("oClock does not exist");
    }
    previousWord = currentWord; // Update the previous word
}