var centerX = room_width / 2;
var centerY = room_height / 2;

var currentWord = global.wordList[global.currentWordIndex];
var targetObject = ds_map_find_value(global.wordToObjectMap, currentWord);

if (global.wordComplete && !is_undefined(targetObject)) {
    //show_debug_message("Word completed: " + currentWord + ", Target Object: " + string(targetObject));

    var posX = irandom_range(735, 1050);
    var posY = irandom_range(110, 350);

    if (!instance_exists(targetObject)) {
        var instanceID = instance_create_layer(posX, posY, "Instances", targetObject);

        if (!is_undefined(instanceID)) {
            instanceID.depth = -1000;
            //show_debug_message("Created instance of " + string(targetObject) + " at (" + string(posX) + ", " + string(posY) + ") with depth -1000");
        } else {
            // show_debug_message("Failed to create instance of " + string(targetObject));
        }
    } else {
        // show_debug_message("Instance already exists for: " + string(targetObject));
    }
}
