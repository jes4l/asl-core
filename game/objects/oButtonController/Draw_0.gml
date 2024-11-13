// Draw Pizza Game Button
draw_set_color(c_black);
draw_rectangle(pizzaX1, pizzaY1, pizzaX2, pizzaY2, false);

draw_set_color(c_white);
draw_rectangle(pizzaX1, pizzaY1, pizzaX2, pizzaY2, true);

draw_set_color(c_white);
draw_set_font(fnt_letter_smallest);
var pizzaTextX = pizzaX1 + buttonPadding;
var pizzaTextY = pizzaY1 + (pizzaButtonHeight - pizzaTextHeight) / 2;
draw_text(pizzaTextX, pizzaTextY, pizzaButtonText);



// Draw Places Game Button
draw_set_color(c_black);
draw_rectangle(placesX1, placesY1, placesX2, placesY2, false);

draw_set_color(c_white);
draw_rectangle(placesX1, placesY1, placesX2, placesY2, true);

draw_set_color(c_white);
draw_set_font(fnt_letter_smallest);
var placesTextX = placesX1 + buttonPadding;
var placesTextY = placesY1 + (placesButtonHeight - placesTextHeight) / 2;
draw_text(placesTextX, placesTextY, placesButtonText);
