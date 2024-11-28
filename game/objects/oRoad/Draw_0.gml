// Save the current drawing color
var prev_color = draw_get_color();
var prev_alpha = draw_get_alpha();

// Set the color to white for the dividing lines
draw_set_color(c_white);

// Draw the dividing lines
var section_width = room_width div 3;
draw_line(section_width, 0, section_width, room_height);     // Left division
draw_line(section_width * 2, 0, section_width * 2, room_height); // Right division

// Restore the previous drawing color and alpha
draw_set_color(prev_color);
draw_set_alpha(prev_alpha);
