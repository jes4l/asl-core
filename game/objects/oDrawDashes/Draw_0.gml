draw_set_alpha(1);
if (global.currentWordLetters != undefined && array_length_1d(global.currentWordLetters) > 0) {
    var letterCount = global.currentWordCount;
    var dashStartX = global.dashStartX;
    var dashEndX = global.dashEndX;
    var dashY = global.dashY;
    var margin = 50;
    var dashStart = dashStartX + margin;
    var dashEnd = dashEndX - margin;
    var dashGap = 25;
    var totalWidth = dashEnd - dashStart;
    var totalGaps = max(0, (letterCount - 1) * dashGap);
    var effectiveWidth = totalWidth - totalGaps;
    var rectWidth = (letterCount > 0) ? (effectiveWidth / letterCount) : 0;
    var rectHeight = 40;
    var currentX = dashStart;
    var outlineWidth = 2;
    for (var i = 0; i < letterCount; i++) {
        var left = currentX;
        var top = dashY - (rectHeight * 0.5);
        var right = currentX + rectWidth;
        var bottom = dashY + (rectHeight * 0.5);
        if (variable_global_exists("currentWordConfidence") && array_length_1d(global.currentWordConfidence) > i) {
            var confidence = global.currentWordConfidence[i];
            if (confidence != -1) {
                var dashColor;
                if (confidence >= 0.66) {
                    dashColor = c_green;
                } else if (confidence >= 0.33) {
                    dashColor = c_orange;
                } else {
                    dashColor = c_red;
                }
                draw_set_color(dashColor);
                draw_rectangle(left, top, right, bottom, false);
            }
        }
        draw_set_color(c_white);
        draw_line_width(left, top, right, top, outlineWidth);
        draw_line_width(left, bottom, right, bottom, outlineWidth);
        draw_line_width(left, top, left, bottom, outlineWidth);
        draw_line_width(right, top, right, bottom, outlineWidth);
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