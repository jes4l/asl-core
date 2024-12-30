// oLetterOnDashes - Destroy Event

if (ds_exists(global.letterErrorCounts, ds_type_map)) {
    ds_map_destroy(global.letterErrorCounts);
    global.letterErrorCounts = undefined;
}
