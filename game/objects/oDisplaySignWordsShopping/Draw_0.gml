if (global.wordComplete) {
    global.wordClearTimer += 1;
    if (global.wordClearTimer >= room_speed * 1.5) {
        global.wordClearTimer = 0;
        global.wordComplete = false;
        global.currentWordIndex += 1;

        if (global.currentWordIndex >= array_length_1d(global.wordList)) {
            show_debug_message("Scan complete!");
            global.currentWordIndex = 0;
            room_goto(rmRoleEnd);
        } else {
            global.letterList = [];
            global.letterAlphas = [];
            global.customDashPositions = [];

            var nextWord = global.wordList[global.currentWordIndex];
            global.targetWord = nextWord;

            if (global.currentWordIndex > 0) {
                var prevWord = global.wordList[global.currentWordIndex - 1];
                var lastCharPrevWord = string_char_at(prevWord, string_length(prevWord));
                var firstCharNextWord = string_char_at(nextWord, 1);

                if (lastCharPrevWord == firstCharNextWord) {
                    array_push(global.letterList, firstCharNextWord);
                    array_push(global.letterAlphas, 1);
					//show_debug_message("Autofilled first letter of next word: " + firstCharNextWord);
                }
            }
        }
    }
} else {
    var currentWord = global.wordList[global.currentWordIndex];
    global.targetWord = currentWord;
    wordDashes(currentWord, "shopping_game");
    autoFillLetters(global.targetWord, global.letterList);

    var comparisonResult = compareLetters(global.targetWord, global.letterList);
    global.correctLetters = comparisonResult.correctLetters;
    global.wordComplete = comparisonResult.wordComplete;
}