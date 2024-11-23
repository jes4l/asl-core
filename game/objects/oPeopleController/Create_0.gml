if (!variable_global_exists("wordToObjectMap")) {
    global.wordToObjectMap = ds_map_create();
    ds_map_add(global.wordToObjectMap, "cab", oChef);
    ds_map_add(global.wordToObjectMap, "abc", oScientist);
	ds_map_add(global.wordToObjectMap, "baa", oFireman);
}
