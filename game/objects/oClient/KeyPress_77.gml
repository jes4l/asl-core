global.activeWords = [];
global.lives = 3;
global.dashStartX = 0;
global.dashEndX   = 0;
global.dashY      = 0;
global.currentSignSprite = "";
if(variable_global_exists("pizzaItems") && global.pizzaItems != undefined && ds_exists(global.pizzaItems, ds_type_list)){
    for(var i = 0; i < ds_list_size(global.pizzaItems); i++){
        var wordSpriteMap = ds_list_find_value(global.pizzaItems, i);
        if(ds_exists(wordSpriteMap, ds_type_map)){
            ds_map_destroy(wordSpriteMap);
        }
    }
    ds_list_destroy(global.pizzaItems);
    global.pizzaItems = undefined;
}
global.chosenSprite = -1;
global.scoreGained = 0;
global.gameComplete = false;
global.oRoleGameSprites = undefined;
room_goto(rmMenu);
