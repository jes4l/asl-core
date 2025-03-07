if (topMessages[currentPoint] != "") {
    scrDrawText(textX, textY, topMessages[currentPoint], textColor, textAlpha, fontToUse);
}

if (currentPoint >= 2) {
    draw_sprite(sBlankTestTube, 0, 920, 500);
    draw_sprite(sBlankTestTube, 0, 1075, 500);
    draw_sprite(sBlankTestTube, 0, 1230, 500);
    draw_sprite(sBlankTestTube, 0, 1385, 500);
}

if (currentPoint >= 4) {
    draw_sprite(sBlankTestTube, 0, 1665, 500);
}
