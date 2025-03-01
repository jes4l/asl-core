draw_set_alpha(1);

var letterFont = fntLetter;
var statusFont = fntLetter;
var statusX    = room_width / 2;
var statusY    = 50;

switch(room) {
    case rmShoppingGame:
        letterFont = fntSevenSegmentLetter;
        statusFont = fntSevenSegment;
        statusX    = 463;
        statusY    = 459;
        break;
    case rmPizzaGame:
        letterFont = fntSevenSegmentLetterPizza;
        statusFont = fntSevenSegment;
        statusX    = 1050;
        statusY    = 520;
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
        letterFont = fntSevenSegmentLetter;
        statusFont = fntSevenSegmentLetter;
        statusX    = 1416;
        statusY    = 883;
        break;
    default:
        letterFont = fntLetter;
        statusFont = fntLetter;
        statusX    = room_width / 2;
        statusY    = 50;
}

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

if (drawOLetterOnDashes) { 
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
}
