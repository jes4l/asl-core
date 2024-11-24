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



// Draw Role Game Button
draw_set_color(c_black);
draw_rectangle(roleX1, roleY1, roleX2, roleY2, false);

draw_set_color(c_white);
draw_rectangle(roleX1, roleY1, roleX2, roleY2, true);

draw_set_color(c_white);
draw_set_font(fnt_letter_smallest);
var roleTextX = roleX1 + buttonPadding;
var roleTextY = roleY1 + (roleButtonHeight - roleTextHeight) / 2;
draw_text(roleTextX, roleTextY, roleButtonText);



// Draw Shopping Game Button
draw_set_color(c_black);
draw_rectangle(shoppingX1, shoppingY1, shoppingX2, shoppingY2, false);

draw_set_color(c_white);
draw_rectangle(shoppingX1, shoppingY1, shoppingX2, shoppingY2, true);

draw_set_color(c_white);
draw_set_font(fnt_letter_smallest);
var shoppingTextX = shoppingX1 + buttonPadding;
var shoppingTextY = shoppingY1 + (shoppingButtonHeight - shoppingTextHeight) / 2;
draw_text(shoppingTextX, shoppingTextY, shoppingButtonText);



// Draw Colours Game Button
draw_set_color(c_black);
draw_rectangle(coloursX1, coloursY1, coloursX2, coloursY2, false);

draw_set_color(c_white);
draw_rectangle(coloursX1, coloursY1, coloursX2, coloursY2, true);

draw_set_color(c_white);
draw_set_font(fnt_letter_smallest);
var coloursTextX = coloursX1 + buttonPadding;
var coloursTextY = coloursY1 + (coloursButtonHeight - coloursTextHeight) / 2;
draw_text(coloursTextX, coloursTextY, coloursButtonText);