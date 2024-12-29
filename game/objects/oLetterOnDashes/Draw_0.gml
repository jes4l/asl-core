// oLetterOnDashes - Draw Event

// Reset alpha to 1 to prevent residual transparency
draw_set_alpha(1);

// Draw the correct letters (green) or partially correct
for (var i = 0; i < letterCount; i++) {
    if (letterAlpha[i] > 0) {
        scrDrawText(
            xPositions[i],             // x-coordinate
            yPositions[i],             // y-coordinate (adjusted)
            letters[i],                // text to draw
            letterColor[i],            // color of the letter
            letterAlpha[i],            // alpha value
            fntLetter                  // font to use
        );
    }
}

// Draw the wrong guess in red
if (wrongLetter != "" && wrongLetterAlpha > 0) {
    scrDrawText(
        wrongLetterX,               // x-coordinate
        wrongLetterY,               // y-coordinate (adjusted)
        wrongLetter,                // text to draw
        c_red,                      // color (red for wrong guess)
        wrongLetterAlpha,           // alpha value
        fntLetter                   // font to use
    );
}

// Optionally display a status message (like "Word Complete!" or "List Complete!")
if (statusMessage != "") {
    scrDrawText(
        room_width / 2,             // x-coordinate (center of the room)
        50,                         // y-coordinate (near top)
        statusMessage,              // text to draw
        c_white,                    // color (white)
        1,                          // alpha value (fully opaque)
        fntLetter                   // font to use
    );
}
