var spriteFrame = 0;
if (variable_global_exists("incorrectWords")) {
    var incCount = ds_list_size(global.incorrectWords);
    if (incCount == 0) {
        spriteFrame = 0;
    } else if (incCount == 1 || incCount == 2) {
        spriteFrame = 1;
    } else if (incCount >= 3) {
        spriteFrame = 2;
    }
}
if (global.chosenSprite != -1) {
    sprite_index = 0;
    draw_sprite_ext(global.chosenSprite, spriteFrame, x, y, 1, 1, 0, c_white, 1);
}
