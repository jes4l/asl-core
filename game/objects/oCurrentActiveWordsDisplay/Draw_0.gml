/// @description Draw the active words in either a row or a column, 
/// ensuring left alignment and consistent spacing among words of various lengths.

// 1) Basic drawing setup
draw_set_alpha(1);
draw_set_font(fntWord);
draw_set_color(c_white);

// Force the text to draw from the top-left corner
draw_set_halign(fa_left);
draw_set_valign(fa_top);

// 2) Check if we actually have any active words
if (!is_array(global.activeWords) || array_length_1d(global.activeWords) == 0) {
    scrDrawText(x, y, "No active words to display!", c_white, 1, fntWord);
    return;
}

// 3) Pre-measure all words to find the largest width and height
var wordCount = array_length_1d(global.activeWords);
var maxWidth  = 0;
var maxHeight = 0;

for (var i = 0; i < wordCount; i++) {
    var thisWord = global.activeWords[i];
    var w = string_width(thisWord);
    var h = string_height(thisWord);

    if (w > maxWidth)   maxWidth  = w;
    if (h > maxHeight)  maxHeight = h;
}

// 4) Define spacing
//    These are the gaps added beyond the max size so words don't touch each other.
var rowSpacing = 20;  // vertical gap between rows
var colSpacing = 50;  // horizontal gap between columns

// 5) Start positions for the first word
var xPos = x;
var yPos = y;

// 6) Draw them
if (activeWordsRow) 
{
    // All words share the same xPos but different yPos
    for (var i = 0; i < wordCount; i++) {
        var word = global.activeWords[i];

        // Draw left-aligned at xPos, yPos
        scrDrawText(xPos, yPos, word, c_white, 1, fntWord);

        // Move down by maxHeight + rowSpacing for consistent spacing
        yPos += maxHeight + rowSpacing;
    }
}
else if (activeWordsColumn) 
{
    // All words share the same yPos but different xPos
    for (var i = 0; i < wordCount; i++) {
        var word = global.activeWords[i];

        // Draw left-aligned at xPos, yPos
        scrDrawText(xPos, yPos, word, c_white, 1, fntWord);

        // Move right by maxWidth + colSpacing
        xPos += maxWidth + colSpacing;
    }
}
else 
{
    // Fallback if neither orientation is specified
    scrDrawText(x, y, "Orientation not set (row/column).", c_white, 1, fntWord);
}
