if (mouse_check_button_pressed(mb_left)) {
    if (point_in_rectangle(mouse_x, mouse_y, pizzaX1, pizzaY1, pizzaX2, pizzaY2)) {
		updateWordList("pizzaGame");
        room_goto(rmPizzaStart);
    }
    if (point_in_rectangle(mouse_x, mouse_y, placesX1, placesY1, placesX2, placesY2)) {
        room_goto(rmPlacesGame);
    }
    if (point_in_rectangle(mouse_x, mouse_y, roleX1, roleY1, roleX2, roleY2)) { // Corrected this line
		updateWordList("roleGame");
        room_goto(rmRoleGame);
    }
}