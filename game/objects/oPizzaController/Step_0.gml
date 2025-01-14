// oRoleController - Step Event

/// @description Manage and Store Previous Words and Sprites

if (letterController != noone) {
    if (ds_exists(letterController.wordsDS, ds_type_list)) {
        // Retrieve the current word using wordIndex
        var currentWord = "";
        if (letterController.wordIndex < ds_list_size(letterController.wordsDS)) {
            currentWord = ds_list_find_value(letterController.wordsDS, letterController.wordIndex);
            currentWord = string_lower(currentWord);
        }

        // Handle when we reach the end of the word list
        if (letterController.wordIndex >= ds_list_size(letterController.wordsDS)) {
            currentWord = "";
        }

        // If currentWord is empty, ensure we store the last previousWord
        if (currentWord == "" && previousWord != "") {
            // Handle the last word explicitly
            scrGetWordPoolSprite(previousWord);
            var lastSprite = sprite_index;

            // Generate 10 random positions and rotations
            var instances = [];
            for (var j = 0; j < 10; j++) {
                var posX = irandom_range(816, 1775);
                var posY = irandom_range(0, 575);
                var rotation = irandom_range(0, 360);
                array_push(instances, { x: posX, y: posY, rotation: rotation });
            }

            // Store the last word's sprite and its instances
            var lastWordMap = ds_map_create();
            ds_map_add(lastWordMap, "word", previousWord);
            ds_map_add(lastWordMap, "sprite", lastSprite);
            ds_map_add(lastWordMap, "instances", instances);

            ds_list_add(previousWordSprites, lastWordMap);

            // Debug message
            show_debug_message("Stored sprite for final word: " + previousWord);

            // Clear previousWord to prevent redundant storage
            previousWord = "";
        }

        // Check if the current word has changed and is valid
        if (currentWord != previousWord && currentWord != "") {
            if (previousWord != "") {
                // Store the previous word's sprite
                scrGetWordPoolSprite(previousWord);
                var prevSprite = sprite_index;

                // Generate 10 random positions and rotations
                var instances = [];
                for (var j = 0; j < 10; j++) {
                    var posX = irandom_range(816, 1775);
                    var posY = irandom_range(0, 575);
                    var rotation = irandom_range(0, 360);
                    array_push(instances, { x: posX, y: posY, rotation: rotation });
                }

                // Store the word, sprite, and instances
                var wordSpriteMap = ds_map_create();
                ds_map_add(wordSpriteMap, "word", previousWord);
                ds_map_add(wordSpriteMap, "sprite", prevSprite);
                ds_map_add(wordSpriteMap, "instances", instances);

                ds_list_add(previousWordSprites, wordSpriteMap);

                // Debug message
                show_debug_message("Stored sprite for previous word: " + previousWord);
            }

            // Update previousWord to the current word
            previousWord = currentWord;
        }
    } else {
        show_debug_message("wordsDS does not exist or is not a ds_list.");
    }
} else {
    show_debug_message("letterController is noone.");
}
