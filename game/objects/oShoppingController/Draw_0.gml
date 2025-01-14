// oShoppingController - Draw Event

/// @description Draw current word sprite at path end, next word sprite traveling from start to offset-dist short of end

// Draw the CURRENT word at the path end
if (currentSprite != -1) {
    draw_sprite_ext(currentSprite, 0, endX, endY, 1, 1, 0, c_white, 1);
}

// Draw the NEXT word at (nextWordX, nextWordY)
if (nextSprite != -1) {
    draw_sprite_ext(nextSprite, 0, nextWordX, nextWordY, 1, 1, 0, c_white, 1);
}
