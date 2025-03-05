if (letterController != noone) {
    if (ds_exists(letterController.wordsDS, ds_type_list)) {
        var currentWord = "";
        
        if (letterController.wordIndex < ds_list_size(letterController.wordsDS)) {
            currentWord = string_lower(ds_list_find_value(letterController.wordsDS, letterController.wordIndex));
        } else {
            show_debug_message("wordIndex out of bounds.");
        }
        
        if (currentWord != previousWord && currentWord != "") {
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
                show_debug_message("No valid sprite found for word: " + currentWord + ". Using sBoard.");
            }
            
            sprite_index = spIndex;
            previousWord = currentWord;
        }
    } else {
        show_debug_message("sprite doesnt exist");
    }
}