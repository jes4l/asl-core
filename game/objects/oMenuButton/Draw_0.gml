draw_set_color(c_black);
draw_rectangle(menuButtonX1, menuButtonY1, menuButtonX2, menuButtonY2, false);

draw_set_color(c_white);
draw_rectangle(menuButtonX1, menuButtonY1, menuButtonX2, menuButtonY2, true);

draw_set_color(c_white);
draw_set_font(fnt_letter_smallest);
var menuTextX = menuButtonX1 + buttonPadding;
var menuTextY = menuButtonY1 + (menuButtonHeight - menuTextHeight) / 2;
draw_text(menuTextX, menuTextY, menuButtonText);