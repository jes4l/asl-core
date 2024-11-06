/// @param {string} phrase - The phrase to create dashes for
/// Draws centered dashes at the bottom of the room based on the given phrase, with gaps for spaces.
function drawWordDashes(phrase) {
    // Split the phrase into individual words
    var wordArray = string_split(phrase, " ");
    var wordCount = array_length(wordArray);

    // Retrieve room dimensions
    var roomWidth = room_width;
    var roomHeight = room_height;

    // Calculate total characters in phrase
    var totalCharacters = string_length(phrase) - wordCount + 1;

    // Estimate initial values for dash width and spacings
    var dashWidth = roomWidth / (4 * totalCharacters); // Smaller dash width
    var intraSpacing = dashWidth / 2;
    var interSpacing = dashWidth;

    // Adjust values to ensure they fit within the room width
    var totalDashLineWidth = calculateTotalDashLineWidth(phrase, dashWidth, intraSpacing, interSpacing);
    while (totalDashLineWidth > roomWidth) {
        dashWidth *= 0.9;
        intraSpacing *= 0.9;
        interSpacing *= 0.9;
        totalDashLineWidth = calculateTotalDashLineWidth(phrase, dashWidth, intraSpacing, interSpacing);
    }

    // Calculate the starting X position to center-align the dashed line
    var lineStartX = (roomWidth - totalDashLineWidth) / 2;
    var linePositionY = roomHeight - 50; // Position of the dashes near the bottom of the room

    // Draw each word as dashes (rectangles), with appropriate spacing between words
    var currentDrawPositionX = lineStartX;
    for (var i = 0; i < wordCount; i++) {
        var word = wordArray[i];
        var wordLength = string_length(word);
        // Draw dashes for the current word
        for (var j = 0; j < wordLength; j++) {
            // Draw a rectangle instead of text for the dash
            draw_rectangle(currentDrawPositionX, linePositionY,
                           currentDrawPositionX + dashWidth, linePositionY + 5, false);
            currentDrawPositionX += dashWidth + intraSpacing;
        }
        // Add spacing between words
        currentDrawPositionX += interSpacing;
    }
}

function calculateTotalDashLineWidth(phrase, dashWidth, intraSpacing, interSpacing) {
    // Split the phrase into individual words
    var wordArray = string_split(phrase, " ");
    var wordCount = array_length(wordArray);

    // Calculate the total width required to center-align all words and spaces
    var totalDashLineWidth = 0;
    for (var i = 0; i < wordCount; i++) {
        var currentWordLength = string_length(wordArray[i]);
        totalDashLineWidth += (currentWordLength * dashWidth) + ((currentWordLength - 1) * intraSpacing);
        // Add extra space between words, except after the last word
        if (i < wordCount - 1) {
            totalDashLineWidth += interSpacing;
        }
    }
    return totalDashLineWidth;
}
