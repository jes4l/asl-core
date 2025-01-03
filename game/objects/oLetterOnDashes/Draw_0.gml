/// oLetterOnDashes - Draw Event

// Reset alpha
draw_set_alpha(1);

// Draw correct letters green or orange
for (var i = 0; i < letterCount; i++) {
    if (letterAlpha[i] > 0) {
        scrDrawText(
            xPositions[i],
            yPositions[i],
            letters[i],
            letterColor[i],
            letterAlpha[i],
            fntLetter
        );
    }
}

// Draw wrong letter guess in red
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

// Optionally display a status message (e.g., "Word Complete!")
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
