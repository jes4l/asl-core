if (!variable_global_exists("positions")) {
    global.positions = ds_map_create();
    ds_map_add(global.positions, "pizza_game", [543, 735]);
    ds_map_add(global.positions, "places_game", [0, 735]); // X will be recalculated for centering
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

        // Re-calculate X position if keyword is "places_game"
        if (keyword == "places_game") {
            startX = calculateCenteredX(phrase);
        }
    } else {
        show_debug_message("Error: Keyword not found in positions map.");
        return;
    }

    setupDashDrawing(phrase, startX, startY);
}

/// Calculate the centered X position for the given phrase
/// @param {string} phrase - The phrase to calculate the centered position for
/// @returns {number} The X position for centered alignment
function calculateCenteredX(phrase) {
    var roomWidth = room_width;
    var letterCount = string_length(string_replace(phrase, " ", ""));
    var wordArray = string_split(phrase, " ");
    var wordCount = array_length(wordArray);

    // Calculate dash and spacing sizes
    var totalUnits = letterCount + (wordCount - 1) * 0.5; // Adjust for inter-word spacing
    var maxDashWidth = roomWidth / totalUnits;
    var dashWidth = maxDashWidth * 0.8;
    var intraSpacing = dashWidth * 0.3;
    var interSpacing = dashWidth * 0.6;

    var totalDashLineWidth = calculateTotalDashLineWidth(phrase, dashWidth, intraSpacing, interSpacing);

    
    var buffer = 25;
    var centeredX = (roomWidth - totalDashLineWidth) / 2 + buffer;

    return centeredX;
}

/// @param {string} phrase - The phrase to draw dashes for
/// @param {number} startX - The starting X position
/// @param {number} startY - The starting Y position
function setupDashDrawing(phrase, startX, startY) {
    var availableWidth = room_width - startX;
    var letterCount = string_length(string_replace(phrase, " ", ""));
    var wordArray = string_split(phrase, " ");
    var wordCount = array_length(wordArray);

    var totalUnits = letterCount + (wordCount - 1) * 0.5;
    var maxDashWidth = availableWidth / totalUnits;
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