// oDrawDashes - Draw Event

// Reset alpha to 1 to prevent residual transparency
draw_set_alpha(1);

// Set the color for dashes
draw_set_color(c_white);

// Check if there is a current word
if (global.currentWordLetters != undefined && array_length_1d(global.currentWordLetters) > 0) {
    var letterCount = global.currentWordCount;
    var dashStartX = global.dashStartX;
    var dashEndX   = global.dashEndX;
    var dashY      = global.dashY;
    var margin = 50;  
    var dashStart = dashStartX + margin;
    var dashEnd   = dashEndX   - margin;
    var dashGap = 25; 
    var totalWidth     = dashEnd - dashStart;
    var totalGaps      = max(0, (letterCount - 1) * dashGap);
    var effectiveWidth = totalWidth - totalGaps;
    var rectWidth      = (letterCount > 0) ? (effectiveWidth / letterCount) : 0;
    var rectHeight     = 40;
    var currentX = dashStart;
    
    for (var i = 0; i < letterCount; i++) {
        var left   = currentX;
        var top    = dashY - (rectHeight * 0.5);
        var right  = currentX + rectWidth;
        var bottom = dashY + (rectHeight * 0.5);
        draw_rectangle(left, top, right, bottom, true);
        currentX += rectWidth + dashGap;
    }
} else {
    // Optionally, draw a default message or clear dashes
    // Use the helper function to draw the default message
    scrDrawText(
        room_width / 2,             // x-coordinate (center of the room)
        room_height / 2,            // y-coordinate (center of the room)
        "No Word Loaded",           // text to draw
        c_white,                    // color
        1,                          // alpha value (fully opaque)
        fntLetter                   // font to use
    );
}
