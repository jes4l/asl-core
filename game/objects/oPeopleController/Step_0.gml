var centerX = room_width / 2;
var centerY = room_height / 2;

var currentWord = global.wordList[global.currentWordIndex];
var targetObject = ds_map_find_value(global.wordToObjectMap, currentWord);

var key = ds_map_find_first(global.wordToObjectMap);
while (!is_undefined(key)) {
    var obj = ds_map_find_value(global.wordToObjectMap, key);

    if (obj != targetObject) {
        with (obj) instance_destroy();
    }
    
    key = ds_map_find_next(global.wordToObjectMap, key);
}

if (!is_undefined(targetObject)) {
    var instance;
    
    if (!instance_exists(targetObject)) {
        instance = instance_create_layer(centerX, centerY, "Instances", targetObject);
        instance.image_xscale = 0;
        instance.image_yscale = 0;
    } else {
        instance = instance_nearest(centerX, centerY, targetObject);
    }

    if (instance.image_xscale < 8) {
        instance.image_xscale += 0.2;
        instance.image_yscale += 0.2;
    }
}