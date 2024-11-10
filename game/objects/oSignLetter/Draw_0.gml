var original_font = draw_get_font();
draw_set_font(fnt_letter);
draw_set_color(c_black);

var nextLetter = "";
var currentLength = array_length_1d(global.letterList);
var correctIndex = 0;
var foundIncorrect = false;

for (var i = 0; i < currentLength; i++) {
    if (global.letterList[i] != string_char_at(global.targetWord, i + 1)) {
        correctIndex = i;
        foundIncorrect = true;
        break;
    }
}

if (!foundIncorrect) {
    correctIndex = currentLength;
}

if (correctIndex < string_length(global.targetWord)) {
    nextLetter = string_char_at(global.targetWord, correctIndex + 1);
}

var textWidth = string_width(nextLetter);
var textHeight = string_height(nextLetter);
var displayX = x + (bbox_right - bbox_left) / 2 - (textWidth / 2);
var displayY = y + (bbox_bottom - bbox_top) / 2 - (textHeight / 2);

draw_text(displayX, displayY, nextLetter);
draw_set_font(original_font);
draw_set_color(c_white);
