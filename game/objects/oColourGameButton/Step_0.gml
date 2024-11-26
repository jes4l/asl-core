if (mouse_check_button_pressed(mb_left)) {
    if (point_in_rectangle(mouse_x, mouse_y, colourX1, colourY1, colourX2, colourY2)) {
        room_goto(rmColourGame);
    }
}