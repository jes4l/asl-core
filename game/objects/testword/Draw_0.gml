// Draw event in otestword
if (global.wordComplete) {
    global.wordClearTimer += 1;
    if (global.wordClearTimer >= room_speed * 1.5) {
        global.wordClearTimer = 0;
        global.wordComplete = false;
        global.currentWordIndex += 1;

        if (global.currentWordIndex >= array_length_1d(global.wordList)) {
            show_debug_message("Order complete!");
            global.currentWordIndex = 0;
        }

        global.letterList = [];
        global.letterAlphas = [];
        global.customDashPositions = [];
    }
} else {
    var currentWord = global.wordList[global.currentWordIndex];
    wordDashes(currentWord, "pizza_game");
}
