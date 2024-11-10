var original_font = draw_get_font();
draw_set_color(c_black);

var startX = x;
var startY = y;
var padding = 10;

draw_set_font(fnt_letter);
draw_text(startX, startY, "Orders:");

var titleHeight = string_height("Orders:");

draw_set_font(fnt_letter_small);
var lineHeight = string_height("A") + 5;

for (var i = 0; i < array_length_1d(global.wordList); i++) {
    var word = global.wordList[i];
    draw_text(startX, startY + titleHeight + padding + (i * lineHeight), word);
}

draw_set_font(original_font);
draw_set_color(c_white);
