draw_set_color(c_black);
draw_rectangle(colourX1, colourY1, colourX2, colourY2, false);

draw_set_color(c_white);
draw_rectangle(colourX1, colourY1, colourX2, colourY2, true);

draw_set_color(c_white);
draw_set_font(fnt_letter_smallest);
var colourTextX = colourX1 + buttonPadding;
var colourTextY = colourY1 + (colourButtonHeight - colourTextHeight) / 2;
draw_text(colourTextX, colourTextY, colourButtonText);