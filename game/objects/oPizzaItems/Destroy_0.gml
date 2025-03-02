if (variable_global_exists("pizzaItems") && global.pizzaItems != undefined && ds_exists(global.pizzaItems, ds_type_list)) {
    for (var i = 0; i < ds_list_size(global.pizzaItems); i++) {
        var wordSpriteMap = ds_list_find_value(global.pizzaItems, i);
        if (ds_exists(wordSpriteMap, ds_type_map)) {
            ds_map_destroy(wordSpriteMap);
        }
    }
    ds_list_destroy(global.pizzaItems);
    global.pizzaItems = undefined;
}
