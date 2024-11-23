var centerX = room_width / 2;
var centerY = room_height / 2;

var currentWord = global.wordList[global.currentWordIndex];
var targetObject = ds_map_find_value(global.wordToObjectMap, currentWord);

if (is_undefined(targetObject)) {
    for (var i = 0; i < ds_map_size(global.wordToObjectMap); i++) {
        var obj = ds_map_find_value(global.wordToObjectMap, ds_map_find_first(global.wordToObjectMap));
        with (obj) instance_destroy();
    }
} else {    
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

    for (var i = 0; i < ds_map_size(global.wordToObjectMap); i++) {
        var obj = ds_map_find_value(global.wordToObjectMap, ds_map_find_first(global.wordToObjectMap));
        if (obj != targetObject) with (obj) instance_destroy();
    }
}
