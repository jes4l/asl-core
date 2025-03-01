if(ds_exists(global.pizzaItems, ds_type_list) && ds_list_size(global.pizzaItems) > 0){
    for(var i = 0; i < ds_list_size(global.pizzaItems); i++){
        var wordSpriteMap = ds_list_find_value(global.pizzaItems, i);
        var spriteToDraw = ds_map_find_value(wordSpriteMap, "sprite");
        var instances = ds_map_find_value(wordSpriteMap, "instances");
        for(var j = 0; j < array_length_1d(instances); j++){
            var inst = instances[j];
            if(pizzaBase != noone && inst.offsetX != undefined){
                var posX = pizzaBase.x + inst.offsetX;
                var posY = pizzaBase.y + inst.offsetY;
            } else {
                var posX = inst.x;
                var posY = inst.y;
            }
            draw_sprite_ext(spriteToDraw, 0, posX, posY, 1, 1, inst.rotation, c_white, 1);
        }
    }
}
