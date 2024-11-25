if (!variable_global_exists("wordToObjectMap")) {
    global.wordToObjectMap = ds_map_create();
    ds_map_add(global.wordToObjectMap, "bac", oApple);
    ds_map_add(global.wordToObjectMap, "cab", oCarrot);
    ds_map_add(global.wordToObjectMap, "abc", oCheese);
}

