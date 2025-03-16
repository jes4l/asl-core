if (global.gameComplete) {
    if (letterController != noone) {
        letterController.statusMessage = "Processing";
    }
    if (processingTimer == -1) {
        processingTimer = room_speed * 2;
    } else {
        processingTimer--;
        if (processingTimer <= 0) {
            for (var i = ds_list_size(loadedSprites) - 1; i >= 0; i--) {
                var sprMap = loadedSprites[| i];
                var word = string_lower(sprMap[? "word"]);
                var removeSprite = false;
                if (ds_exists(global.incorrectWords, ds_type_list)) {
                    for (var j = 0; j < ds_list_size(global.incorrectWords); j++) {
                        var incWord = string_lower(ds_list_find_value(global.incorrectWords, j));
                        if (incWord == word) {
                            removeSprite = true;
                            break;
                        }
                    }
                }
                if (removeSprite) {
                    ds_list_delete(loadedSprites, i);
                }
            }
            global.oRoleGameSprites = loadedSprites;
            room_goto(rmRoleGameEnd);
        }
    }
    return;
}

if (letterController != noone) {
    if (ds_exists(letterController.wordsDS, ds_type_list)) {
        var currentWord = "";
        if (letterController.wordIndex < ds_list_size(letterController.wordsDS)) {
            currentWord = string_lower(ds_list_find_value(letterController.wordsDS, letterController.wordIndex));
        }
        if (currentWord != previousWord && currentWord != "") {
            var isIncorrect = false;
            if (ds_exists(global.incorrectWords, ds_type_list)) {
                for (var j = 0; j < ds_list_size(global.incorrectWords); j++) {
                    var incWord = string_lower(ds_list_find_value(global.incorrectWords, j));
                    if (incWord == currentWord) {
                        isIncorrect = true;
                        break;
                    }
                }
            }
            if (isIncorrect) {
                previousWord = currentWord;
                return;
            }
            
            var suffix = choose("M", "F");
            var spriteName = "s" + string_upper(string_char_at(currentWord, 1)) + string_delete(currentWord, 1, 1) + suffix;
            var spIndex = asset_get_index(spriteName);
            if (spIndex == -1) {
                var otherSuffix = (suffix == "M") ? "F" : "M";
                spriteName = "s" + string_upper(string_char_at(currentWord, 1)) + string_delete(currentWord, 1, 1) + otherSuffix;
                spIndex = asset_get_index(spriteName);
            }
            if (spIndex == -1) {
                spriteName = "s" + string_upper(string_char_at(currentWord, 1)) + string_delete(currentWord, 1, 1);
                spIndex = asset_get_index(spriteName);
            }
            if (spIndex == -1) {
                spIndex = sBoard;
            }
            sprite_index = spIndex;
            image_index = 0;
            previousWord = currentWord;
            
            var alreadyAdded = false;
            for (var i = 0; i < ds_list_size(loadedSprites); i++) {
                var tempMap = loadedSprites[| i];
                if (tempMap[? "sprite"] == spIndex) {
                    alreadyAdded = true;
                    break;
                }
            }
            if (!alreadyAdded) {
                var sprMap = ds_map_create();
                sprMap[? "sprite"] = spIndex;
                sprMap[? "word"] = currentWord;
                sprMap[? "spriteName"] = spriteName;
                ds_list_add(loadedSprites, sprMap);
            }
        }
    }
}
