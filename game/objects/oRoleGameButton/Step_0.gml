if (mouse_check_button_pressed(mb_left)) {
    if (point_in_rectangle(mouse_x, mouse_y, roleX1, roleY1, roleX2, roleY2)) {
        room_goto(rmRoleGame);
    }
}