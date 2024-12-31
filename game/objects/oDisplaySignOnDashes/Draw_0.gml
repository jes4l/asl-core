// oDisplaySignOnDashes - Draw Event

/// @description Draw ASL signs on top of letters

// Ensure that oLetterOnDashes instance exists
if (instance_exists(letterOnDashesInstance)) {
    // Access letters and their properties from oLetterOnDashes
    var letters = letterOnDashesInstance.letters;
    var letterCount = letterOnDashesInstance.letterCount;
    var xPositions = letterOnDashesInstance.xPositions;
    var yPositions = letterOnDashesInstance.yPositions;
    var letterAlpha = letterOnDashesInstance.letterAlpha;
    var letterColor = letterOnDashesInstance.letterColor;
    
    // Iterate through all letters in the current word
    for (var i = 0; i < letterCount; i++) {
        var currentLetter = letters[i];
        var alphaValue = letterAlpha[i];
        
        // Get the ASL sprite for the current letter
        var aslSprite = scrGetASLSprite(currentLetter);
        
        if (aslSprite != -1) {
            // Get the position for the letter
            var x_pos = xPositions[i];
            var y_pos = yPositions[i];
            
            // Set the alpha based on letterAlpha[i]
            draw_set_alpha(alphaValue);
            
            // Draw the ASL sprite on top of the letter
            draw_sprite(aslSprite, 0, x_pos, y_pos);
        } else {
            show_debug_message("ASL sprite for letter '" + string(currentLetter) + "' not found.");
        }
    }
    
    // Handle wrong letters (if any)
    var wrongLetter = letterOnDashesInstance.wrongLetter;
    var wrongLetterAlpha = letterOnDashesInstance.wrongLetterAlpha;
    var wrongLetterX = letterOnDashesInstance.wrongLetterX;
    var wrongLetterY = letterOnDashesInstance.wrongLetterY;
    
    if (wrongLetter != "" && wrongLetterAlpha > 0) {
        var aslWrongSprite = scrGetASLSprite(wrongLetter);
        
        if (aslWrongSprite != -1) {
            // Set alpha for wrong letter sign
            draw_set_alpha(wrongLetterAlpha);
            
            // Draw the ASL sprite for the wrong letter
            draw_sprite(aslWrongSprite, 0, wrongLetterX, wrongLetterY);
        } else {
            show_debug_message("ASL sprite for wrong letter '" + string(wrongLetter) + "' not found.");
        }
    }
    
    // Reset alpha to default to avoid affecting other drawings
    draw_set_alpha(1);
}
