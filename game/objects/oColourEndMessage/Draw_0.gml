var finalText = timeRemainingText;
if (timeRemainingText == "You Made My Potion With:" && variable_global_exists("activeWords") && global.activeWords != undefined) {
    var wordsStr = "";
    for (var i = 0; i < array_length_1d(global.activeWords); i++) {
        wordsStr += global.activeWords[i];
        if (i < array_length_1d(global.activeWords) - 1) {
            wordsStr += " ";
        }
    }
    finalText = finalText + "\n" + wordsStr;
}
scrDrawText(textX, textY, finalText, textColor, textAlpha, fontToUse);