var incCount = 0;
if (variable_global_exists("incorrectWords") && global.incorrectWords != undefined) {
    incCount = ds_list_size(global.incorrectWords);
}

if (global.chosenSprite != -1) {
    if (incCount == 0) {
        image_index = 0;
    }
    else if (incCount > 0 && incCount < 3) {
        image_index = 1;
    }
    else if (incCount >= 3) {
        image_index = 2;
    }
    draw_sprite_ext(global.chosenSprite, image_index, x, y, 1, 1, 0, c_white, 1);
}
