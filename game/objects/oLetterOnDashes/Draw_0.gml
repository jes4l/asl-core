// Reset alpha
draw_set_alpha(1);

// Draw revealed letters (green or orange, etc.)
for (var i = 0; i < letterCount; i++) {
    if (letterAlpha[i] > 0) {
        scrDrawText(
            xPositions[i],        // x
            yPositions[i],        // y
            letters[i],           // the letter
            letterColor[i],       // color
            letterAlpha[i],       // alpha
            fntLetter             // font
        );
    }
}

// Draw the WRONG letter overlay (fades out)
if (wrongLetter != "" && wrongLetterAlpha > 0) {
    scrDrawText(
        wrongLetterX, 
        wrongLetterY,
        wrongLetter,
        c_red, 
        wrongLetterAlpha,
        fntLetter
    );
}

// Optionally display a status message (like “Word Complete!” or “List Complete!”)
if (statusMessage != "") {
    scrDrawText(
        room_width / 2,
        50,
        statusMessage,
        c_white,
        1,
        fntLetter
    );
}
