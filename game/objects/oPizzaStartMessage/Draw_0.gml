if (topMessages[currentPoint] != "") {
    scrDrawText(textX, textY, topMessages[currentPoint], textColor, textAlpha, fontToUse);
}
if (currentPoint == 0) {
    if (variable_global_exists("activeWords") && global.activeWords != undefined) {
        var wordsStr = "";
        for (var i = 0; i < array_length_1d(global.activeWords); i++) {
            wordsStr += global.activeWords[i];
            if (i < array_length_1d(global.activeWords) - 1) {
                wordsStr += " ";
            }
        }
        scrDrawText(textX, 475, wordsStr, textColor, textAlpha, fontToUse);
    }
} else if (bottomMessages[currentPoint] != "") {
    scrDrawText(textX, 475, bottomMessages[currentPoint], textColor, textAlpha, fontToUse);
}