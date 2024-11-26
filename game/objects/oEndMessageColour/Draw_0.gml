var originalFont = draw_get_font();
var originalColor = draw_get_color();

draw_set_font(fnt_letter_smallest);
draw_set_color(c_white);

var text = "You Have Healed Me!";
var roomWidth = room_width;
var roomHeight = room_height;
var xPosition = roomWidth / 2 - string_width(text) / 2;
var yPosition = roomHeight * 0.35 - string_height(text) / 2;
draw_text(xPosition, yPosition, text);

draw_set_font(originalFont);
draw_set_color(originalColor);