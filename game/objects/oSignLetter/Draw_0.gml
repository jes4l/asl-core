function draw_centered_text(x, y, text, font) {
    var original_font = draw_get_font();
    draw_set_font(font);
    var textWidth = string_width(text);
    var textHeight = string_height(text);
    var displayX = x - (textWidth / 2);
    var displayY = y - (textHeight / 2);
    draw_text(displayX, displayY, text);
    draw_set_font(original_font);
}

draw_set_color(c_black);

var signText = "Sign";
var signFont = fnt_letter_smallest;
var signX = x + (bbox_right - bbox_left) / 2;
var signY = y + (bbox_bottom - bbox_top) * 0.1;
draw_centered_text(signX, signY, signText, signFont);

var nextLetter = getNextLetter(global.letterList, global.targetWord);
var letterFont = fnt_letter;
var letterX = x + (bbox_right - bbox_left) / 2;
var letterY = y + (bbox_bottom - bbox_top) / 2;
draw_centered_text(letterX, letterY, nextLetter, letterFont);

draw_set_color(-1);
