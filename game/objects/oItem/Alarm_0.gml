if (path_position == 0.5) {
    path_position = 1; 
    path_speed = 0;
    // show_debug_message("Object moved to end of path: " + string(id));
    alarm[0] = room_speed * 10;
} 
else if (path_position == 1) {
    // show_debug_message("Object at end destroyed: " + string(id));
    instance_destroy();
    with (oShoppingItemController) {
        createMiddleObject();
    }
}
