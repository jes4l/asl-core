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
            scrGetWordPoolSprite(currentWord + suffix, true);
            
            previousWord = currentWord;
        }
    } else {
        show_debug_message("sprite doesnt exist");
    }
}