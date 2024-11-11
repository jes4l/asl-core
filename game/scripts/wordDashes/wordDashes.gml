// Create a global dictionary for positions
if (!variable_global_exists("positions")) {
    global.positions = ds_map_create();
    ds_map_add(global.positions, "pizza_game", [543, 735]);
    // ds_map_add(global.positions, "game", [100, 200]);
}

/// @param {string} phrase - The phrase to create dashes for
/// @param {string} keyword - The keyword to determine the starting position
function wordDashes(phrase, keyword) {
    global.targetWord = phrase;

    var startX, startY;
    if (ds_map_exists(global.positions, keyword)) {
        var position = ds_map_find_value(global.positions, keyword);
        startX = position[0];
        startY = position[1];
    } else {
        show_debug_message("Error: Keyword not found in positions map.");
        return;
    }

    var roomWidth = room_width;
    var availableWidth = roomWidth - startX;

    var letterCount = string_length(string_replace(phrase, " ", ""));
    var wordArray = string_split(phrase, " ");
    var wordCount = array_length(wordArray);

    var maxDashWidth = availableWidth / (letterCount + wordCount * 0.5);
    var dashWidth = maxDashWidth * 0.8;
    var intraSpacing = dashWidth * 0.3;
    var interSpacing = dashWidth * 0.6;

    var totalDashLineWidth = calculateTotalDashLineWidth(phrase, dashWidth, intraSpacing, interSpacing);
    if (totalDashLineWidth > availableWidth) {
        var scaleFactor = availableWidth / totalDashLineWidth;
        dashWidth *= scaleFactor;
        intraSpacing *= scaleFactor;
        interSpacing *= scaleFactor;
    }

    global.dashWidth = dashWidth;
    global.dashHeight = 5;
    global.customDashPositions = [];

    var currentDrawPositionX = startX;
    for (var i = 0; i < wordCount; i++) {
        var word = wordArray[i];
        var wordLength = string_length(word);

        for (var j = 0; j < wordLength; j++) {
            draw_rectangle(currentDrawPositionX, startY,
                           currentDrawPositionX + dashWidth, startY + global.dashHeight, false);
            array_push(global.customDashPositions, [currentDrawPositionX, startY]);
            currentDrawPositionX += dashWidth + intraSpacing;
        }
        
        if (i < wordCount - 1) {
            currentDrawPositionX += interSpacing;
        }
    }
}

function calculateTotalDashLineWidth(phrase, dashWidth, intraSpacing, interSpacing) {
    var wordArray = string_split(phrase, " ");
    var wordCount = array_length(wordArray);

    var totalDashLineWidth = 0;
    for (var i = 0; i < wordCount; i++) {
        var currentWordLength = string_length(wordArray[i]);
        totalDashLineWidth += (currentWordLength * dashWidth) + ((currentWordLength - 1) * intraSpacing);

        if (i < wordCount - 1) {
            totalDashLineWidth += interSpacing;
        }
    }
    return totalDashLineWidth;
}
