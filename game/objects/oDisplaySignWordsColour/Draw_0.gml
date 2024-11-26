if (mouse_check_button_pressed(mb_left)) {
    var mx = mouse_x;
    var my = mouse_y;
    // show_debug_message("Mouse clicked at: " + string(mx) + ", " + string(my));
    var correctTestTube = ds_map_find_value(global.wordToObjectMap, global.targetWord);
    // show_debug_message("Current target word: " + global.targetWord);
    // show_debug_message("Correct test tube object: " + string(correctTestTube));
    
    if (instance_position(mx, my, correctTestTube)) {
        // show_debug_message("Correct test tube clicked!");
        instance_create_layer(correctTestTube.x, correctTestTube.y - 20, layer, oGreenTick);
        global.wordClearTimer = room_speed * 2;
        global.wordPending = true;
    } else {
        // show_debug_message("Incorrect test tube clicked or no test tube at position.");
        var clickedTestTube = instance_position(mx, my, all);
        if (clickedTestTube != noone) {
            instance_create_layer(clickedTestTube.x, clickedTestTube.y - 20, layer, oRedCross);
        }
    }
}

if (global.wordPending) {
    var message = "That is the correct test tube";
    var textWidth = string_width(message);
    var centerX = (room_width / 2) - (textWidth / 2);
    var messageY = 20;
    draw_text(centerX, messageY, message);
}
