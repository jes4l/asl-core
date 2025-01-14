// oRoleController - Draw Event

/// @description Draw Stored Sprites for Previous Words

if (ds_exists(previousWordSprites, ds_type_list) && ds_list_size(previousWordSprites) > 0) {
    for (var i = 0; i < ds_list_size(previousWordSprites); i++) {
        var wordSpriteMap = ds_list_find_value(previousWordSprites, i);

        // Retrieve word, sprite, and instances
        var spriteToDraw = ds_map_find_value(wordSpriteMap, "sprite");
        var instances = ds_map_find_value(wordSpriteMap, "instances");

        // Iterate through the stored instances and draw the sprite
        for (var j = 0; j < array_length_1d(instances); j++) {
            var instance = instances[j];
            var posX = instance.x;
            var posY = instance.y;
            var rotation = instance.rotation;

            // Draw the sprite at the position with the specified rotation
            draw_sprite_ext(spriteToDraw, 0, posX, posY, 1, 1, rotation, c_white, 1);
        }
    }
}
