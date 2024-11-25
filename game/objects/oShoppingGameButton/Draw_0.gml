draw_set_color(c_black);
draw_rectangle(shoppingX1, shoppingY1, shoppingX2, shoppingY2, false);

draw_set_color(c_white);
draw_rectangle(shoppingX1, shoppingY1, shoppingX2, shoppingY2, true);

draw_set_color(c_white);
draw_set_font(fnt_letter_smallest);
var shoppingTextX = shoppingX1 + buttonPadding;
var shoppingTextY = shoppingY1 + (shoppingButtonHeight - shoppingTextHeight) / 2;
draw_text(shoppingTextX, shoppingTextY, shoppingButtonText);