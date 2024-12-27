draw_set_font(fntButton);
draw_set_color(c_black);
draw_rectangle(x1, y1, x2, y2, false);
draw_set_color(c_white);
draw_rectangle(x1, y1, x2, y2, true);

var textX = x1 + (buttonPadding);
var textY = y1 + (buttonPadding);
draw_text(textX, textY, buttonText);
