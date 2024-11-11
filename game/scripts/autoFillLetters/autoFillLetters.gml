function autoFillLetters(targetWord, letterList) {
    var targetLength = string_length(targetWord);
    var letterCount = array_length_1d(letterList);
    var minLength = min(targetLength, letterCount);
    var consecutiveLetters = [];

    for (var i = 0; i < minLength; i++) {
        var targetChar = string_char_at(targetWord, i + 1);
        var nextChar = (i < targetLength - 1) ? string_char_at(targetWord, i + 2) : "";
        
        if (letterList[i] == targetChar) {
            if (targetChar == nextChar && letterCount == i + 1) {
                array_push(consecutiveLetters, nextChar);
            }
        } else {
            break;
        }
    }

    for (var j = 0; j < array_length_1d(consecutiveLetters); j++) {
        array_push(letterList, consecutiveLetters[j]);
        array_push(global.letterAlphas, 1);
        //show_debug_message("Autofilled consecutive letter: " + consecutiveLetters[j]);
    }

    consecutiveLetters = [];
}
