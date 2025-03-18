var endInst = instance_find(oShoppingEnd, 0);
if ((endInst != noone && endInst.allBagsStopped) || (variable_global_exists("correctWords") && array_length_1d(global.correctWords) == 0 && noBags <= 0)) {
    if (!scoreShown) {
        scoreShown = true;
    }
    scrDrawText(textX, textY, msg2_1, textColor, textAlpha, fontToUse);
    scrDrawText(textX, 390, msg2_2, textColor, textAlpha, fontToUse);
} else {
    scrDrawText(textX, textY, msg1_1, textColor, textAlpha, fontToUse);
    scrDrawText(textX, 390, msg1_2, textColor, textAlpha, fontToUse);
}
