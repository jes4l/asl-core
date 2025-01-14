// oPlaces - Create Event

/// @description Sets the sprite using scrGetWordPoolSprite for the active word,
// and initializes movement properties (similar to an obstacle).

if (is_array(global.activeWords) && array_length_1d(global.activeWords) > 0) {
    var word = global.activeWords[0]; // e.g., "hospital"

    // Use the scrGetWordPoolSprite function
    scrGetWordPoolSprite(word); // This sets sprite_index for this object
    
    // Optional: Movement speed (downward, or however you'd like it to move)
    fallSpeed = 4;
    show_debug_message("oPlaces created with word: " + word);
} else {
    // If no active word, just assign default sprite or destroy
    sprite_index = sBoard;
    show_debug_message("oPlaces: No active word found. Using sBoard.");
}

// Alternatively, if you want it stationary, set fallSpeed = 0 (or skip entirely).
