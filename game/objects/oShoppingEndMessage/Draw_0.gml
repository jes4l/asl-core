var endInst = instance_find(oShoppingEnd, 0);
if (endInst != noone && endInst.allBagsStopped) {
    if (!scoreShown) {
        alarm[0] = room_speed * 5;
        scoreShown = true;
    }
    timeRemainingText = "You Got A Score Of " + string(global.scoreGained) + "\nThis Is Your Overall Score " + string(global.score);
    scrDrawText(textX, textY, timeRemainingText, textColor, textAlpha, fontToUse);
    scrDrawText(textX, 390, "I Cannot Wait to Eat This", textColor, textAlpha, fontToUse);
} else {
    scrDrawText(textX, textY, timeRemainingText, textColor, textAlpha, fontToUse);
    scrDrawText(textX, 390, activeWordsText, textColor, textAlpha, fontToUse);
}
