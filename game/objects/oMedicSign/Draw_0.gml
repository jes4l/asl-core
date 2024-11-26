var original_font = draw_get_font();
var original_color = draw_get_color();

draw_self();
draw_set_font(fnt_letter_smallest);
draw_set_color(c_white);

var text = "Medic Lab";
var x_offset = sprite_width + 0;
var y_position = sprite_height / 30 - string_height(text) / 2;
draw_text(x + x_offset, y + y_position, text);

draw_set_font(original_font);
draw_set_color(original_color);