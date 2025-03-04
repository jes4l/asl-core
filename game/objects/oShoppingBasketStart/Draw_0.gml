if (topMessages[currentPoint] != "") {
    scrDrawText(textX, textY, topMessages[currentPoint], textColor, textAlpha, fontToUse);
}
if (variable_global_exists("activeWords") && global.activeWords != undefined) {
    var offsetX = basket.x - 267;
    var offsetY = basket.y - 695;
    var regionLeft = 130 + offsetX;
    var regionRight = 395 + offsetX;
    var regionBaseY = 620 + offsetY;
    if (regionBaseY < 620) regionBaseY = 620;
    var activeSpriteY = regionBaseY - 65;
    var wordsCount = array_length_1d(global.activeWords);
    if (wordsCount > 0) {
        if (wordsCount == 1) {
            var xPos = (regionLeft + regionRight) * 0.5;
            var spr = scrGetWordPoolSprite(global.activeWords[0], false);
            draw_sprite(spr, 0, xPos, activeSpriteY);
        } else {
            var spacing = (regionRight - regionLeft) / (wordsCount - 1);
            for (var i = 0; i < wordsCount; i++) {
                var xPos = regionLeft + i * spacing;
                var spr = scrGetWordPoolSprite(global.activeWords[i], false);
                draw_sprite(spr, 0, xPos, activeSpriteY);
            }
        }
    }
}
if (bottomMessages[currentPoint] != "") {
    var offsetY = basket.y - 695;
    var regionBaseY = 620 + offsetY;
    if (regionBaseY < 620) regionBaseY = 620;
    scrDrawText(textX + 20, regionBaseY - 235, bottomMessages[currentPoint], textColor, textAlpha, fontToUse);
}
