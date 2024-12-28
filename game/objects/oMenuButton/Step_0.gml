if (mouse_check_button_pressed(mb_left)) {
    if (point_in_rectangle(mouse_x, mouse_y, x1, y1, x2, y2)) {
        if (variable_global_exists("activeWords")) {
            global.activeWords = [];
        }

        global.dashStartX = 0;
        global.dashEndX   = 0;
        global.dashY      = 0;
        room_goto(rmMenu);
    }
}
