function compareLetters(targetWord, letterList) {
    var correctLetters = [];
    var targetLength = string_length(targetWord);
    var letterCount = array_length_1d(letterList);
    var minLength = min(targetLength, letterCount);
    var wordComplete = true;
    
    var autoFillIndex = -1; // Track index for consecutive letters

    for (var i = 0; i < minLength; i++) {
        var targetChar = string_char_at(targetWord, i + 1);
        var typedChar = letterList[i];

        if (typedChar == targetChar) {
            array_push(correctLetters, true);
            array_push(global.letterAlphas, 1);
            
            // Check if the next character is the same (consecutive letter)
            if (i < targetLength - 1 && string_char_at(targetWord, i + 2) == targetChar) {
                autoFillIndex = i + 1; // Mark for auto-fill
            }
        } else {
            array_push(correctLetters, false);
            array_push(global.letterAlphas, 1);
            wordComplete = false;
        }
    }

    // Handle any auto-fills if necessary
    if (autoFillIndex != -1 && letterCount <= autoFillIndex) {
        // Auto-fill the consecutive letter
        array_push(letterList, string_char_at(targetWord, autoFillIndex + 1));
        array_push(correctLetters, true);
        array_push(global.letterAlphas, 1);
    }

    if (letterCount > targetLength) {
        for (var j = minLength; j < letterCount; j++) {
            array_push(correctLetters, false);
            array_push(global.letterAlphas, 1);
            wordComplete = false;
        }
    }

    if (letterCount < targetLength) {
        wordComplete = false;
    }

    return {correctLetters: correctLetters, wordComplete: wordComplete};
}
