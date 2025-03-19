draw_set_alpha(1);

draw_set_color(c_white);

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
    scrDrawText(
        room_width / 2,
        room_height / 2,
        "No Word Loaded",
        c_white,
        1,
        fntSevenSegment80
    );
}
