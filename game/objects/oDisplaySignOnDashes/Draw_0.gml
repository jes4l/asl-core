if (instance_exists(letterOnDashesInstance)) {
    var letters = letterOnDashesInstance.letters;
    var letterCount = letterOnDashesInstance.letterCount;
    var xPositions = letterOnDashesInstance.xPositions;
    var yPositions = letterOnDashesInstance.yPositions;
    var letterAlpha = letterOnDashesInstance.letterAlpha;
    var letterColor = letterOnDashesInstance.letterColor;
    var yOffsetPizzaGame = -115;
    var yOffsetDefault = -50;
    var yOffset = (room == rmPizzaGame) ? yOffsetPizzaGame : yOffsetDefault;
    
    for (var i = 0; i < letterCount; i++) {
        var currentLetter = letters[i];
        var alphaValue = letterAlpha[i];
        var aslSprite = scrGetASLSprite(currentLetter);
        
        if (aslSprite != -1) {
            var x_pos = xPositions[i];
            var y_pos = yPositions[i] + yOffset;
            draw_set_alpha(alphaValue);
            draw_sprite_ext(aslSprite, 0, x_pos, y_pos, 0.5, 0.5, 0, c_white, alphaValue);
        } else {
            show_debug_message("ASL sprite for letter '" + string(currentLetter) + "' not found.");
        }
    }
    
    var wrongLetter = letterOnDashesInstance.wrongLetter;
    var wrongLetterAlpha = letterOnDashesInstance.wrongLetterAlpha;
    var wrongLetterX = letterOnDashesInstance.wrongLetterX;
    var wrongLetterY = letterOnDashesInstance.wrongLetterY;
    
    if (wrongLetter != "" && wrongLetterAlpha > 0) {
        var aslWrongSprite = scrGetASLSprite(wrongLetter);
        
        if (aslWrongSprite != -1) {
            var adjustedWrongY = wrongLetterY + yOffset;
            draw_set_alpha(wrongLetterAlpha);
            draw_sprite_ext(aslWrongSprite, 0, wrongLetterX, adjustedWrongY, 0.5, 0.5, 0, c_white, wrongLetterAlpha);
        } else {
            show_debug_message("ASL sprite for wrong letter '" + string(wrongLetter) + "' not found.");
        }
    }
    
    draw_set_alpha(1);
} else {
    show_debug_message("oLetterOnDashes instance does not exist.");
}
