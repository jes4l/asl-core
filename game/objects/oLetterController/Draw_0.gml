draw_self();

var char = string_char_at(global.msg, 1);

// Get the room width and height
var room_w = room_width;
var room_h = room_height;

// Calculate the center position
var center_x = room_w / 2;
var center_y = room_h / 2;

// Store the current font
var original_font = draw_get_font();

// Set the new font
draw_set_font(fnt_letter);

// Draw the character at the center of the room
draw_text(center_x, center_y, char);

// Restore the original font
draw_set_font(original_font);
