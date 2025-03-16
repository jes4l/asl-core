var msg = "";
if (displayStage == 0) {
    msg = msg1;
} else if (displayStage == 1) {
    msg = msg2;
} else if (displayStage == 2 && hasIncorrect) {
    msg = msg3;
} else if (displayStage == 3) {
    msg = msg4;
}
scrDrawText(centerX, centerY, msg, textColor, textAlpha, fontToUse);