if (timeRemainingText != "") {
    if (leftAlignMessage) {
        draw_set_font(fontToUse);
        draw_set_alpha(textAlpha);
        draw_set_color(textColor);
        draw_set_halign(fa_left);
        draw_text(textX, textY, timeRemainingText);
    } else {
        scrDrawText(textX, textY, timeRemainingText, textColor, textAlpha, fontToUse);
    }
}
if (showParkSign) {
    draw_sprite_ext(sPark, 0, 1715, 100, 0.6, 0.6, 0, c_white, 1);
}
if (showObstacleSprite) {
    draw_sprite_ext(obstacleSprites[obstacleIndex], 0, 1715, 100, 0.9, 0.9, 0, c_white, 1);
}
