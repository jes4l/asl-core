global.msg += global.previousLetters;
global.previousLetters = "";

for (var i = 1; i <= string_length(global.msg); i++) {
    var letter = string_char_at(global.msg, i);
    array_push(global.letterList, letter);
}

global.msg = "";

drawLettersOnDashes();
