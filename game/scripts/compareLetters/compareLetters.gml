function compareLetters(targetWord, letterList) {
    var correctLetters = [];
    var targetLength = string_length(targetWord);
    var letterCount = array_length_1d(letterList);

    // Limit the loop to the minimum length between targetWord and letterList
    var minLength = min(targetLength, letterCount);
    
    for (var i = 0; i < minLength; i++) {
        var targetChar = string_char_at(targetWord, i + 1); // 1-based index in GML for strings
        var typedChar = letterList[i];
        
        // Debug message to track comparisons
        show_debug_message("Comparing: " + typedChar + " with " + targetChar);
        
        if (typedChar == targetChar) {
            array_push(correctLetters, true);  // Correct letter
        } else {
            array_push(correctLetters, false); // Incorrect letter
        }
    }

    // Fill remaining slots in correctLetters with false if letterList is longer than targetWord
    if (letterCount > targetLength) {
        for (var j = minLength; j < letterCount; j++) {
            array_push(correctLetters, false);
        }
    }

    return correctLetters;
}
