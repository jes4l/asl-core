// oCurrentLetterDisplay - Draw Event

/// @description Draw the current letter to be signed, centered within the object
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
        
        // Draw the current letter using the existing scrDrawText script
        // The letter is drawn at the object's (x, y) position, centered within the object
        scrDrawText(
            x,              // X-coordinate (center of the object)
            y,              // Y-coordinate (center of the object)
            currentLetter,  // Text to draw
            c_white,        // Color of the text
            1,              // Alpha value (fully opaque)
            fntLetter       // Font to use (ensure this font exists)
        );
    }
} else {
    show_debug_message("oLetterOnDashe doesnt exist");
}
