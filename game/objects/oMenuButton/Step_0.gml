if (mouse_check_button_pressed(mb_left)) {
    if (point_in_rectangle(mouse_x, mouse_y, x1, y1, x2, y2)) {
        if (variable_global_exists("activeWords")) {
            global.activeWords = []; 
        }
        room_goto(rmMenu);
    }
}
