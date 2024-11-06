function drawLettersOnDashes() {
    var dashPositions = global.customDashPositions;

    // Exit if no dash positions are set
    if (array_length_1d(dashPositions) == 0) {
        return;
    }

    // Ensure dashWidth and dashHeight are defined
    if (global.dashWidth == 0 || global.dashHeight == 0) {
        show_debug_message("Error: dashWidth or dashHeight is undefined.");
        return;
    }

    // Set the font for drawing letters
    var original_font = draw_get_font();
    draw_set_font(fnt_letter);

    // Get dash count and letter count
    var dashCount = array_length_1d(dashPositions);
    var letterCount = array_length_1d(global.letterList);
    var targetWordLength = string_length(global.targetWord);

    // Get correct letters array
    global.correctLetters = compareLetters(global.targetWord, global.letterList);
    show_debug_message("Correct Letters: " + string(global.correctLetters)); // Debug message

    // Output the current input
    show_debug_message("Current Input: " + string(global.letterList)); // Debug message

    // Draw each letter centered on top of the corresponding dash
    for (var i = 0; i < letterCount; i++) {
        var char = global.letterList[i]; // Get the character from list
        if (i < dashCount) {
            var pos = dashPositions[i];
            var posX = pos[0] + (global.dashWidth / 2) - (string_width(char) / 2);
            var posY = pos[1] - global.dashHeight - string_height(char);

            // Check if the character is correct
            if (global.correctLetters[i]) {
                draw_set_color(c_green); // Correct letter
            } else {
                draw_set_color(c_red); // Incorrect letter
            }

            // Draw the letter on top of the dash
            draw_text(posX, posY, char);
        }
    }

    // Restore the original font and color
    draw_set_font(original_font);
    draw_set_color(c_white);
}
