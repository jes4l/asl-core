if (global.currentSignSprite != -1) {
    if (room == rmPlacesGame) {
        draw_sprite_ext(global.currentSignSprite, 0, x, y, 1.4, 1.4, 0, c_white, 1);
    } else {
        draw_sprite(global.currentSignSprite, 0, x, y);
    }
}
