var msg = "";
if (displayStage == 0) {
    msg = "Thank You For Filling In Our Tax Form:";
} else if (displayStage == 1) {
    var activeWordsStr = "";
    if (is_array(global.activeWords)) {
        for (var i = 0; i < array_length(global.activeWords); i++) {
            activeWordsStr += global.activeWords[i];
            if (i < array_length(global.activeWords) - 1) {
                activeWordsStr += ", ";
            }
        }
    } else {
        activeWordsStr = string(global.activeWords);
    }
    msg = "You Have identified our roles correctly,\n" + activeWordsStr;
} else if (displayStage == 2) {
    msg = "You Got A Score Of " + string(global.scoreGained) + "\nThis Is Your Overall Score " + string(global.score);
}
scrDrawText(centerX, centerY, msg, textColor, textAlpha, fontToUse);
