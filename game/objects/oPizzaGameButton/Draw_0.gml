draw_set_color(c_black);
draw_rectangle(pizzaX1, pizzaY1, pizzaX2, pizzaY2, false);

draw_set_color(c_white);
draw_rectangle(pizzaX1, pizzaY1, pizzaX2, pizzaY2, true);

draw_set_color(c_white);
draw_set_font(fnt_letter_smallest);
var pizzaTextX = pizzaX1 + buttonPadding;
var pizzaTextY = pizzaY1 + (pizzaButtonHeight - pizzaTextHeight) / 2;
draw_text(pizzaTextX, pizzaTextY, pizzaButtonText);
