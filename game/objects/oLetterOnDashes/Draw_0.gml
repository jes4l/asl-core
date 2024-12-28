// oLetterOnDashes - Draw Event

// Draw the correct letters (green) or partially correct
for (var i = 0; i < letterCount; i++) {
    if (letterAlpha[i] > 0) {
        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);
        draw_set_color(letterColor[i]);
        draw_set_alpha(letterAlpha[i]);
        draw_text(xPositions[i], yPositions[i], letters[i]);
    }
}

// Draw the wrong guess in red
if (wrongLetter != "" && wrongLetterAlpha > 0) {
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_color(c_red);
    draw_set_alpha(wrongLetterAlpha);
    draw_text(wrongLetterX, wrongLetterY, wrongLetter);
}

// Optionally display a status message (like "Word Complete!" or "List Complete!")
draw_set_alpha(1);
draw_set_color(c_white);
draw_set_halign(fa_center); // Center align for better visibility
draw_set_valign(fa_top);

if (statusMessage != "") {
    // Draw the message at the center-top of the screen
    draw_text(room_width / 2, 50, statusMessage);
}
