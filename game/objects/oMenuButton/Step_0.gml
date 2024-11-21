if (mouse_check_button_pressed(mb_left)) {
    if (point_in_rectangle(mouse_x, mouse_y, menuButtonX1, menuButtonY1, menuButtonX2, menuButtonY2)) {

        // Reset global variables and game states
        global.msg = "";
        global.previousLetters = "";
        global.customDashPositions = [];
        global.letterList = [];
        global.letterAlphas = [];
        global.dashWidth = 0;
        global.dashHeight = 0;
        global.targetWord = "";
        global.correctLetters = [];
        global.currentWordIndex = 0;
        global.wordComplete = false;
        global.wordClearTimer = 0;
        global.pizzaOrderSentence = "";
        global.pizzaOrderEnd = "";
        global.wordList = [];
		
        for (var i = 0; i < ds_list_size(global.initialWordList); i++) {
            array_push(global.wordList, ds_list_find_value(global.initialWordList, i));
        }
        room_goto(rmMenu);
    }
}
