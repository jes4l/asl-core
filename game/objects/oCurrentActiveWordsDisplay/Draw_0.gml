draw_self();

draw_set_alpha(1);
draw_set_font(fntGreekRolls70);
draw_set_color(c_black);

draw_set_halign(fa_left);
draw_set_valign(fa_top);

if (!is_array(global.activeWords) || array_length_1d(global.activeWords) == 0) {
    scrDrawText(x, y, "No active words to display!", c_black, 1, fntWord);
    return;
}

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

var rowSpacing = 20;
var colSpacing = 50;

var xPos = x;
var yPos = y;

if (activeWordsRow) 
{
    for (var i = 0; i < wordCount; i++) {
        var word = global.activeWords[i];
        scrDrawText(xPos, yPos, word, c_black, 1, fntGreekRolls70);
        yPos += maxHeight + rowSpacing;
    }
}
else if (activeWordsColumn) 
{
    for (var i = 0; i < wordCount; i++) {
        var word = global.activeWords[i];
        scrDrawText(xPos, yPos, word, c_black, 1, fntGreekRolls70);
        xPos += maxWidth + colSpacing;
    }
}
else 
{
    scrDrawText(x, y, "Orientation not set (row/column).", c_black, 1, fntWord);
}
