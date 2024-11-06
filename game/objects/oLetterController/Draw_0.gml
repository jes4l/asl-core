// Append new letters to global.msg and store each in letterList
global.msg += global.previousLetters;
global.previousLetters = "";

for (var i = 1; i <= string_length(global.msg); i++) {
    var letter = string_char_at(global.msg, i);
    array_push(global.letterList, letter);
}

// Clear global.msg to prevent duplicates
global.msg = "";

// Draw all letters on dashes
drawLettersOnDashes();
