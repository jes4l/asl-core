if (is_array(global.activeWords) && array_length_1d(global.activeWords) > 0) {
    var word = global.activeWords[0];

    scrGetWordPoolSprite(word);
    
    fallSpeed = 4;
    show_debug_message("oPlaces created with word: " + word);
} else {

    sprite_index = sBoard;
    show_debug_message("oPlaces: No active word found. Using sBoard.");
}