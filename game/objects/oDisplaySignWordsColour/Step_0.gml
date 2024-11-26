if (global.wordPending) {
    global.wordClearTimer -= 1;

    if (global.wordClearTimer <= 0) {
        global.wordComplete = true;
        global.wordPending = false;
        global.wordClearTimer = 0;
        
        global.currentWordIndex += 1;
        if (global.currentWordIndex >= array_length_1d(global.wordList)) {
            // show_debug_message("All words completed!");
            global.currentWordIndex = 0;
            room_goto(rmRoleEnd);
        } else {
            global.targetWord = global.wordList[global.currentWordIndex];
            // show_debug_message("Next target word: " + global.targetWord);
        }
    }
}

if (!global.wordComplete) {
    var currentWord = global.wordList[global.currentWordIndex];
    global.targetWord = currentWord;
    // show_debug_message("Setting target word: " + global.targetWord);
    wordDashes(currentWord, "colour_game");
}
