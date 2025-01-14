// oRoleController - Destroy Event

/// @description Clean Up Resources

if (ds_exists(previousWordSprites, ds_type_list)) {
    for (var i = 0; i < ds_list_size(previousWordSprites); i++) {
        var wordSpriteMap = ds_list_find_value(previousWordSprites, i);
        if (ds_exists(wordSpriteMap, ds_type_map)) {
            ds_map_destroy(wordSpriteMap);
        }
    }
    ds_list_destroy(previousWordSprites);
}
