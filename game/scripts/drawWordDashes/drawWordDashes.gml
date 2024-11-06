/// @param {string} phrase - The phrase to create dashes for
function drawWordDashes(phrase) {
    var wordArray = string_split(phrase, " ");
    var wordCount = array_length(wordArray);

    var roomWidth = room_width;
    var roomHeight = room_height;

    // Calculate initial dash dimensions and spacings
    var totalCharacters = string_length(phrase) - wordCount + 1;
    var dashWidth = roomWidth / (4 * totalCharacters);
    var intraSpacing = dashWidth / 2;
    var interSpacing = dashWidth;

    // Recalculate if total dash width exceeds room width
    var totalDashLineWidth = calculateTotalDashLineWidth(phrase, dashWidth, intraSpacing, interSpacing);
    while (totalDashLineWidth > roomWidth) {
        dashWidth *= 0.9;
        intraSpacing *= 0.9;
        interSpacing *= 0.9;
        totalDashLineWidth = calculateTotalDashLineWidth(phrase, dashWidth, intraSpacing, interSpacing);
    }

    var lineStartX = (roomWidth - totalDashLineWidth) / 2;
    var linePositionY = roomHeight - 50;

    global.customDashPositions = [];  // Reset dash positions

    var currentDrawPositionX = lineStartX;
    for (var i = 0; i < wordCount; i++) {
        var word = wordArray[i];
        var wordLength = string_length(word);

        for (var j = 0; j < wordLength; j++) {
            draw_rectangle(currentDrawPositionX, linePositionY,
                           currentDrawPositionX + dashWidth, linePositionY + 5, false);
            array_push(global.customDashPositions, [currentDrawPositionX, linePositionY]);  // Store position
            currentDrawPositionX += dashWidth + intraSpacing;
        }

        currentDrawPositionX += interSpacing;
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
