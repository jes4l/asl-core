function drawLettersOnDashes() {
    var dashPositions = global.customDashPositions;
    if (array_length_1d(dashPositions) == 0) {
        return;
    }

    if (global.dashWidth == 0 || global.dashHeight == 0) {
        show_debug_message("Error: dashWidth or dashHeight is undefined.");
        return;
    }

    var comparisonResult = compareLetters(global.targetWord, global.letterList);
    global.correctLetters = comparisonResult.correctLetters;
    var wordComplete = comparisonResult.wordComplete;

    var original_font = draw_get_font();
    draw_set_font(fnt_letter);

    var dashCount = array_length_1d(dashPositions);
    var i = 0;

    while (i < array_length_1d(global.letterList)) {
        var char = global.letterList[i];
        if (i < dashCount) {
            var pos = dashPositions[i];
            var posX = pos[0] + (global.dashWidth / 2) - (string_width(char) / 2);
            var posY = pos[1] - global.dashHeight - string_height(char);

            if (!global.correctLetters[i]) {
                draw_set_color(c_red);
                global.letterAlphas[i] -= 0.02;

                if (global.letterAlphas[i] <= 0) {
                    array_delete(global.letterList, i, 1);
                    array_delete(global.letterAlphas, i, 1);
                    array_delete(global.correctLetters, i, 1);
                    continue;
                }
            } else {
                draw_set_color(c_green);
                global.letterAlphas[i] = 1;
            }

            draw_set_alpha(global.letterAlphas[i]);
            draw_text(posX, posY, char);
        }

        i++;
    }

    draw_set_font(original_font);
    draw_set_color(c_white);
    draw_set_alpha(1);

    if (wordComplete) {
        global.wordComplete = true;
        show_debug_message("Word is complete!");
    } else {
        global.wordComplete = false;
    }
}
