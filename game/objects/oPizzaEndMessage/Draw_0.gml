var pb = instance_find(oPizzaBase, 0);
if (pb != noone && pb.reachedEnd) {
    if (!scoreShown) {
        alarm[0] = room_speed * 5;
        scoreShown = true;
    }
    timeRemainingText = "You Got A Score Of" + string(global.scoreGained) + "\n This Is Your Overall Score " + string(global.score);
    scrDrawText(textX, textY, timeRemainingText, textColor, textAlpha, fontToUse);
    scrDrawText(textX, 470, "I Cannot Wait To Eat This!", textColor, textAlpha, fontToUse);
} else {
    if (timeRemainingText != "") {
        scrDrawText(textX, textY, timeRemainingText, textColor, textAlpha, fontToUse);
    }
    if (variable_global_exists("activeWords") && global.activeWords != undefined) {
        var wordsStr = "";
        for (var i = 0; i < array_length_1d(global.activeWords); i++) {
            wordsStr += global.activeWords[i];
            if (i < array_length_1d(global.activeWords) - 1) {
                wordsStr += " ";
            }
        }
        scrDrawText(textX, 470, wordsStr, textColor, textAlpha, fontToUse);
    }
}
