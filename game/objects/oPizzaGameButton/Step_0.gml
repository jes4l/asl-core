if (mouse_check_button_pressed(mb_left)) {
    if (point_in_rectangle(mouse_x, mouse_y, pizzaX1, pizzaY1, pizzaX2, pizzaY2)) {
        room_goto(rmPizzaGame);
    }
}