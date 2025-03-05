if (topMessages[currentPoint] != "") {
    scrDrawText(textX, textY, topMessages[currentPoint], textColor, textAlpha, fontToUse);
}
if (bottomMessages[currentPoint] != "") {
    scrDrawText(textX, bottomMessageY, bottomMessages[currentPoint], textColor, textAlpha, fontToUse);
}
