if (timeRemainingText != "") {
    scrDrawText(
        textX,
        textY,
        timeRemainingText,
        textColor,
        textAlpha,
        fontToUse
    );
}

if (variable_global_exists("activeWords") && global.activeWords != undefined) {
    var wordsStr = "";
    for (var i = 0; i < array_length_1d(global.activeWords); i++) {
        wordsStr += global.activeWords[i];
        if (i < array_length_1d(global.activeWords) - 1) {
            wordsStr += " ";
        }
    }
    scrDrawText(
        textX,
        470,
        wordsStr,
        textColor,
        textAlpha,
        fontToUse
    );
}
