if (global.chosenSprite != -1) {
	sprite_index = 3;
    if (room == rmColourGameEnd) {
        if (global.scoreGained == 60) {
            image_index = 3;
        } else if (global.scoreGained == 40 || global.scoreGained == 50 ||global.scoreGained == 30) {
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
