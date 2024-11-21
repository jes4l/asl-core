menuButtonText = "Menu";
buttonPadding = 10;

draw_set_font(fnt_letter_smallest);
menuTextWidth = string_width(menuButtonText);
menuTextHeight = string_height(menuButtonText);

menuButtonWidth = menuTextWidth + buttonPadding * 2;
menuButtonHeight = menuTextHeight + buttonPadding * 2;

menuButtonX1 = room_width - menuButtonWidth - buttonPadding;
menuButtonY1 = room_height - menuButtonHeight - buttonPadding;
menuButtonX2 = menuButtonX1 + menuButtonWidth;
menuButtonY2 = menuButtonY1 + menuButtonHeight;

// Store the initial state of global.wordList
if (!variable_global_exists("initialWordList")) {
    global.initialWordList = ds_list_create();
    for (var i = 0; i < array_length(global.wordList); i++) {
        ds_list_add(global.initialWordList, global.wordList[i]);
    }
}
