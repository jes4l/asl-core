draw_set_alpha(1);
var letterFont = fntSevenSegment100;
var statusFont = fntSevenSegment100;
var statusX = room_width / 2;
var statusY = 50;
switch(room) {
    case rmShoppingGame:
        letterFont = fntSevenSegment100;
        statusFont = fntSevenSegment80;
        statusX = 463;
        statusY = 459;
        break;
    case rmPizzaGame:
        letterFont = fntSevenSegment80;
        statusFont = fntSevenSegment80;
        statusX = 1100;
        statusY = 550;
        break;
    case rmRoleGame:
        letterFont = fntSevenSegment100;
        statusFont = fntSevenSegment100;
        statusX = 1416;
        statusY = 883;
        break;
    default:
        letterFont = fntSevenSegment100;
        statusFont = fntSevenSegment100;
        statusX = room_width / 2;
        statusY = 50;
}
if (statusMessage != "") {
    scrDrawText(statusX, statusY, statusMessage, c_white, 1, statusFont);
}
if (drawOLetterOnDashes) {
    for (var i = 0; i < letterCount; i++) {
        if (letterAlpha[i] > 0) {
            scrDrawText(xPositions[i], yPositions[i], letters[i], letterColor[i], letterAlpha[i], letterFont);
        }
    }
    if (wrongLetter != "" && wrongLetterAlpha > 0) {
        scrDrawText(wrongLetterX, wrongLetterY, wrongLetter, c_red, wrongLetterAlpha, letterFont);
    }
}
