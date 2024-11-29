var prev_color = draw_get_color();
var prev_alpha = draw_get_alpha();

draw_set_color(c_white);

var section_width = room_width div 3;
draw_line(section_width, 0, section_width, room_height);
draw_line(section_width * 2, 0, section_width * 2, room_height);

draw_set_color(prev_color);
draw_set_alpha(prev_alpha);