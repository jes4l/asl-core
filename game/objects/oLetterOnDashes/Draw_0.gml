// oLetterOnDashes - Draw Event

if (drawOLetterOnDashes) { 
    // Reset alpha
    draw_set_alpha(1);
	
	var letterFont = fntLetter;
	var statusFont = fntLetter;
	var statusX    = room_width / 2;
	var statusY    = 50;

    // Select fonts and positions based on the current room
    switch(room) {
        case rmShoppingGame:
            letterFont = fntSevenSegmentLetter;
            statusFont = fntSevenSegment;
            statusX    = 463;
            statusY    = 459;
            break;
        case rmPizzaGame:
            letterFont = fntLetter;
            statusFont = fntLetter;
            statusX    = room_width / 2;
            statusY    = 50;
            break;
        case rmPlacesGame:
            letterFont = fntLetter;
            statusFont = fntLetter;
            statusX    = room_width / 2;
            statusY    = 50;
            break;
        case rmColourGame:
            letterFont = fntLetter;
            statusFont = fntLetter;
            statusX    = room_width / 2;
            statusY    = 50;
            break;
        case rmRoleGame:
            letterFont = fntLetter;
            statusFont = fntLetter;
            statusX    = room_width / 2;
            statusY    = 50;
            break;
        default:
            // Fallback settings for undefined rooms
            letterFont = fntLetter;
            statusFont = fntLetter;
            statusX    = room_width / 2;
            statusY    = 50;
    }


    // **Draw Correct Letters (Green or Orange)**
    for (var i = 0; i < letterCount; i++) {
        if (letterAlpha[i] > 0) {
            scrDrawText(
                xPositions[i],
                yPositions[i],
                letters[i],
                letterColor[i],
                letterAlpha[i],
                letterFont
            );
        }
    }

    // **Draw Wrong Letter Guess in Red**
    if (wrongLetter != "" && wrongLetterAlpha > 0) {
        scrDrawText(
            wrongLetterX,
            wrongLetterY,
            wrongLetter,
            c_red,
            wrongLetterAlpha,
            letterFont
        );
    }

    // **Draw Status Message with Dynamic Font and Position**
    if (statusMessage != "") {
        scrDrawText(
            statusX,
            statusY,
            statusMessage,
            c_white,
            1,
            statusFont
        );
    }
	
}
