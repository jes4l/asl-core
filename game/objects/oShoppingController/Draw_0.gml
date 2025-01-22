// oShoppingController - Draw Event

/// @description Draws the current word’s sprite at the interpolated position

if (currentSprite != -1) {
    draw_sprite_ext(
        currentSprite, 
        0, 
        currentWordX, 
        currentWordY, 
        1, 1, 
        0, 
        c_white, 
        1
    );
}
