if (!variable_global_exists("gameWordLists")) {
    global.gameWordLists = ds_map_create();
    ds_map_add(global.gameWordLists, "pizzaGame", ["caa", "aac", "abc"]);
    ds_map_add(global.gameWordLists, "roleGame", ["baa", "cab", "abc"]);
	ds_map_add(global.gameWordLists, "shoppingGame", ["bac", "cab", "abc"]);
}