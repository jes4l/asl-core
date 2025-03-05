timeRemainingText = "Thank You For Scanning My Items:";
textX = 580;
textY = 170;
fontToUse = fntSevenSegmentMessagePizza;
textColor = c_white;
textAlpha = 1;
scoreShown = false;
activeWordsText = "";
if (variable_global_exists("activeWords") && global.activeWords != undefined) {
    for (var i = 0; i < array_length_1d(global.activeWords); i++) {
        activeWordsText += global.activeWords[i];
        if (i < array_length_1d(global.activeWords) - 1) {
            activeWordsText += " ";
        }
    }
}
