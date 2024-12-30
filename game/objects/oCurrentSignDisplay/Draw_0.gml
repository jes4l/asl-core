// oCurrentSignDisplay - Draw Event

/// @description Draw the current sign language sprite to be performed

// First, draw the object itself (if it has a sprite)
draw_self();

// Ensure that the oLetterOnDashes instance exists
if (instance_exists(letterOnDashesInstance)) {
    // Access the global array of letters for the current word
    var letters = global.currentWordLetters;
    
    // Access the current index from oLetterOnDashes to determine the next letter to sign
    var currentIndex = letterOnDashesInstance.currentIndex;
    // Check if the current index is within the bounds of the letters array
    if (currentIndex < array_length_1d(letters)) {
        // Retrieve the current letter
        var currentLetter = letters[currentIndex];
        
        // Ensure the letter is uppercase to match sprite naming convention
        var upperLetter = string_upper(currentLetter);
        
        // Construct the sprite name based on the current letter
        // Example: 'A' -> 'sAASL', 'B' -> 'sBASL', etc.
        var spriteName = "s" + upperLetter + "ASL";
        // Get the sprite index using the sprite name
        var spriteIndex = asset_get_index(spriteName);
        
        // Check if the sprite exists
        if (spriteIndex != -1) {
            // Draw the sprite centered within the object
            draw_sprite(spriteIndex, 0, x, y);
        }
        else {
            show_debug_message("Sprite not found - " + spriteName);
        }
    }
    else {
        show_debug_message("No more letters to display.");
    }
}
else {
    show_debug_message("oLetterOnDashes instance does not exist");
}
