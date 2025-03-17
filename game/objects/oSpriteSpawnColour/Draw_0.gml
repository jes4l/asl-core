if (global.chosenSprite != -1) {
    if (room == rmColourGameEnd) {
        if (global.scoreGained == 6) {
            image_index = 3;
        } else if (global.scoreGained == 4 || global.scoreGained == 5 ||global.scoreGained == 3) {
            image_index = 1;
        } else {
            image_index = 2;
        }
    } else {
        if (incorrectCount == 0) {
            image_index = 3;
        } else if (incorrectCount == 1) {
            image_index = 1;
        } else {
            image_index = 2;
        }
    }
    draw_sprite_ext(global.chosenSprite, image_index, x, y, 1, 1, 0, c_white, 1);
}
