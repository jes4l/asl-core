function drawLettersOnDashes() {
    var dashPositions = global.customDashPositions;
    if (array_length_1d(dashPositions) == 0) {
        return;
    }

    if (global.dashWidth == 0 || global.dashHeight == 0) {
        show_debug_message("Error: dashWidth or dashHeight is undefined.");
        return;
    }

    // Ensure correctLetters is updated to match the current letterList
    global.correctLetters = compareLetters(global.targetWord, global.letterList);

    var original_font = draw_get_font();
    draw_set_font(fnt_letter);

    var dashCount = array_length_1d(dashPositions);
    var i = 0;

    // Use a while loop to handle dynamic list resizing when removing letters
    while (i < array_length_1d(global.letterList)) {
        var char = global.letterList[i];
        if (i < dashCount) {
            var pos = dashPositions[i];
            var posX = pos[0] + (global.dashWidth / 2) - (string_width(char) / 2);
            var posY = pos[1] - global.dashHeight - string_height(char);

            // Handle color and alpha for correct/incorrect letters
            if (!global.correctLetters[i]) {
                draw_set_color(c_red); // Incorrect letter color
                global.letterAlphas[i] -= 0.02; // Reduce alpha for fade effect

                if (global.letterAlphas[i] <= 0) {
                    // Remove the letter and its alpha value
                    array_delete(global.letterList, i, 1);
                    array_delete(global.letterAlphas, i, 1);
                    array_delete(global.correctLetters, i, 1);
                    continue; // Skip incrementing i to handle the next element correctly
                }
            } else {
                draw_set_color(c_green); // Correct letter color
                global.letterAlphas[i] = 1; // Ensure full opacity for correct letters
            }

            // Set alpha and draw the letter
            draw_set_alpha(global.letterAlphas[i]);
            draw_text(posX, posY, char);
        }

        i++; // Increment index only if no letter is removed
    }

    // Reset font and color settings after drawing
    draw_set_font(original_font);
    draw_set_color(c_white);
    draw_set_alpha(1);
}
