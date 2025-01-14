// oRoleController - Step Event

/// @description Update Role Sprite Based on Current Word

// Ensure the letterController reference is valid
if (letterController != noone) {
    // Ensure that wordsDS exists and is a ds_list
    if (ds_exists(letterController.wordsDS, ds_type_list)) {
        // Retrieve the current word using wordIndex
        var currentWord = "";
        
        if (letterController.wordIndex < ds_list_size(letterController.wordsDS)) {
            currentWord = string_lower(ds_list_find_value(letterController.wordsDS, letterController.wordIndex));
        } else {
            show_debug_message("wordIndex out of bounds.");
        }
        
        // Check if the current word has changed
        if (currentWord != previousWord && currentWord != "") {
            // Update the sprite based on the new word
            scrGetWordPoolSprite(currentWord);
            
            // Update previousWord
            previousWord = currentWord;
        }
    } else {
        show_debug_message("sprite doesnt exist");
    }
}
