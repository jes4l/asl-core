draw_set_color(c_black);
draw_rectangle(roleX1, roleY1, roleX2, roleY2, false);

draw_set_color(c_white);
draw_rectangle(roleX1, roleY1, roleX2, roleY2, true);

draw_set_color(c_white);
draw_set_font(fnt_letter_smallest);
var roleTextX = roleX1 + buttonPadding;
var roleTextY = roleY1 + (roleButtonHeight - roleTextHeight) / 2;
draw_text(roleTextX, roleTextY, roleButtonText);