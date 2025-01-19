if (timeRemainingText != "") {
    var offset = 1;
    
  
    scrDrawText(textX, textY, timeRemainingText, textColor, textAlpha, fontToUse);
    scrDrawText(textX + offset, textY, timeRemainingText, textColor, textAlpha, fontToUse);
    scrDrawText(textX - offset, textY, timeRemainingText, textColor, textAlpha, fontToUse);
    scrDrawText(textX, textY + offset, timeRemainingText, textColor, textAlpha, fontToUse);
    scrDrawText(textX, textY - offset, timeRemainingText, textColor, textAlpha, fontToUse);
}
