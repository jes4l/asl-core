if (!variable_global_exists("wordToObjectMap")) {
    global.wordToObjectMap = ds_map_create();
    ds_map_add(global.wordToObjectMap, "caa", oCorn);
    ds_map_add(global.wordToObjectMap, "aac", oPine);
    ds_map_add(global.wordToObjectMap, "abc", oPeppers);
}


var key = ds_map_find_first(global.wordToObjectMap);
while (!is_undefined(key)) {
    var obj = ds_map_find_value(global.wordToObjectMap, key);
    with (obj) instance_destroy();
    key = ds_map_find_next(global.wordToObjectMap, key);
}
