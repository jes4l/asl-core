if(global.gameComplete) {
    if(letterController != noone) {
        letterController.statusMessage = "Processing";
    }
    if(processingTimer == -1) {
        processingTimer = room_speed * 2;
    } else {
        processingTimer--;
        if(processingTimer <= 0) {
            global.oRoleGameSprites = loadedSprites;
            room_goto(rmRoleGameEnd);
        }
    }
    return;
}
if(letterController != noone) {
    if(ds_exists(letterController.wordsDS, ds_type_list)) {
        var currentWord = "";
        if(letterController.wordIndex < ds_list_size(letterController.wordsDS)) {
            currentWord = string_lower(ds_list_find_value(letterController.wordsDS, letterController.wordIndex));
        }
        if(currentWord != previousWord && currentWord != "") {
            var suffix = choose("M", "F");
            var spriteName = "s" + string_upper(string_char_at(currentWord, 1)) + string_delete(currentWord, 1, 1) + suffix;
            var spIndex = asset_get_index(spriteName);
            if(spIndex == -1) {
                var otherSuffix = (suffix == "M") ? "F" : "M";
                spriteName = "s" + string_upper(string_char_at(currentWord, 1)) + string_delete(currentWord, 1, 1) + otherSuffix;
                spIndex = asset_get_index(spriteName);
            }
            if(spIndex == -1) {
                spriteName = "s" + string_upper(string_char_at(currentWord, 1)) + string_delete(currentWord, 1, 1);
                spIndex = asset_get_index(spriteName);
            }
            if(spIndex == -1) {
                spIndex = sBoard;
            }
            sprite_index = spIndex;
            previousWord = currentWord;
            var alreadyAdded = false;
            for(var i = 0; i < ds_list_size(loadedSprites); i++) {
                var tempMap = loadedSprites[| i];
                if(tempMap[? "sprite"] == spIndex) {
                    alreadyAdded = true;
                    break;
                }
            }
            if(!alreadyAdded) {
                var sprMap = ds_map_create();
                sprMap[? "sprite"] = spIndex;
                sprMap[? "word"] = currentWord;
                sprMap[? "spriteName"] = spriteName;
                ds_list_add(loadedSprites, sprMap);
            }
        }
    }
}
