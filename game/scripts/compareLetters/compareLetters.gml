function compareLetters(targetWord, letterList) {
    var correctLetters = [];
    var targetLength = string_length(targetWord);
    var letterCount = array_length_1d(letterList);
    var minLength = min(targetLength, letterCount);
    var wordComplete = true;
    
    for (var i = 0; i < minLength; i++) {
        var targetChar = string_char_at(targetWord, i + 1);
        var typedChar = letterList[i];

        if (typedChar == targetChar) {
            array_push(correctLetters, true);
            array_push(global.letterAlphas, 1);
        } else {
            array_push(correctLetters, false);
            array_push(global.letterAlphas, 1);
            wordComplete = false;
        }
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