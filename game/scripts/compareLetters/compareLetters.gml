function compareLetters(targetWord, letterList) {
    var correctLetters = [];
    var targetLength = string_length(targetWord);
    var letterCount = array_length_1d(letterList);
    var minLength = min(targetLength, letterCount);
    
    for (var i = 0; i < minLength; i++) {
        var targetChar = string_char_at(targetWord, i + 1);
        var typedChar = letterList[i];
        
        show_debug_message("Comparing: " + typedChar + " with " + targetChar);

        if (typedChar == targetChar) {
            array_push(correctLetters, true);
            array_push(global.letterAlphas, 1); // Reset alpha for correct letters
        } else {
            array_push(correctLetters, false);
            array_push(global.letterAlphas, 1); // Reset alpha for incorrect letters
        }
    }

    // Fill remaining slots in correctLetters and letterAlphas if needed
    if (letterCount > targetLength) {
        for (var j = minLength; j < letterCount; j++) {
            array_push(correctLetters, false);
            array_push(global.letterAlphas, 1); // Fade extra characters
        }
    }

    return correctLetters;
}
