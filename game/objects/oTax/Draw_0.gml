draw_self();

var original_font = draw_get_font();
var original_color = draw_get_color();

var objWidth = bbox_right - bbox_left;
var objHeight = bbox_bottom - bbox_top;

var centerX = x + objWidth / 2;
var topY = y + 40;

var taxFormText = "Tax Form";
draw_set_font(fnt_letter_small);
var taxFormWidth = string_width(taxFormText);
var taxFormHeight = string_height(taxFormText);
draw_text(centerX - taxFormWidth / 2, topY, taxFormText);

var roleText = "Role:";
draw_set_font(fnt_letter_smallest);
var roleTextWidth = string_width(roleText);
var roleTextHeight = string_height(roleText);
draw_text(centerX - roleTextWidth / 2, topY + taxFormHeight + 5, roleText);

draw_set_font(original_font);
draw_set_color(original_color);
