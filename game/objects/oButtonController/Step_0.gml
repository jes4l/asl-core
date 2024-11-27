if (mouse_check_button_pressed(mb_left)) {
    if (point_in_rectangle(mouse_x, mouse_y, pizzaX1, pizzaY1, pizzaX2, pizzaY2)) {
		updateWordList("pizzaGame");
        room_goto(rmPizzaStart);
    }
    if (point_in_rectangle(mouse_x, mouse_y, placesX1, placesY1, placesX2, placesY2)) {
		updateWordList("placesGame");
		room_goto(rmPlacesGame);
    }
    if (point_in_rectangle(mouse_x, mouse_y, roleX1, roleY1, roleX2, roleY2)) { // Corrected this line
		updateWordList("roleGame");
        room_goto(rmRoleStart);
    }	
	if (point_in_rectangle(mouse_x, mouse_y, shoppingX1, shoppingY1, shoppingX2, shoppingY2)) {
		updateWordList("shoppingGame");
		room_goto(rmShoppingStart);
	}
	
	if (point_in_rectangle(mouse_x, mouse_y, coloursX1, coloursY1, coloursX2, coloursY2)) {
		updateWordList("colourGame");
		room_goto(rmColourStart);
}
	
}