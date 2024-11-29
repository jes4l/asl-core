if (global.wordComplete) {
    global.wordClearTimer += 1;

    if (global.wordClearTimer >= room_speed * 1.5) {
        global.wordClearTimer = 0;
        global.wordComplete = false;
        global.currentWordIndex += 1;

        if (global.currentWordIndex >= array_length_1d(global.wordList)) {
            show_debug_message("Order complete!");
            global.currentWordIndex = 0;
            room_goto(rmMenu);
        } else {
            global.letterList = [];
            global.letterAlphas = [];
            global.customDashPositions = [];

            if (global.currentWordIndex < array_length_1d(global.wordList)) {
                var nextWord = global.wordList[global.currentWordIndex];
                global.targetWord = nextWord;

                if (global.currentWordIndex > 0) {
                    var prevWord = global.wordList[global.currentWordIndex - 1];
                    var lastCharPrevWord = string_char_at(prevWord, string_length(prevWord));
                    var firstCharNextWord = string_char_at(nextWord, 1);

                    if (lastCharPrevWord == firstCharNextWord) {
                        array_push(global.letterList, firstCharNextWord);
                        array_push(global.letterAlphas, 1);
                    }
                }
            } else {
                show_debug_message("Error: currentWordIndex out of bounds after advancement.");
            }
        }
    }
} else {
    // Ensure currentWordIndex is valid before accessing the word list
    if (global.currentWordIndex < array_length_1d(global.wordList)) {
        var currentWord = global.wordList[global.currentWordIndex];
        global.targetWord = currentWord;
        wordDashes(currentWord, "places_game");
        autoFillLetters(global.targetWord, global.letterList);

        var comparisonResult = compareLetters(global.targetWord, global.letterList);
        global.correctLetters = comparisonResult.correctLetters;
        global.wordComplete = comparisonResult.wordComplete;
    } else {
        show_debug_message("Error: currentWordIndex out of bounds during draw phase.");
        global.currentWordIndex = 0;
        room_goto(rmMenu);
    }
}

// Check if the oClock timer has run out
if (oClock.timerCurrent <= 0) {
    room_goto(rmCarGame);
}
