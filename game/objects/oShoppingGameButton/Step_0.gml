if (mouse_check_button_pressed(mb_left)) {
    if (point_in_rectangle(mouse_x, mouse_y, shoppingX1, shoppingY1, shoppingX2, shoppingY2)) {
        room_goto(rmShoppingGame);
    }
}