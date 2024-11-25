var originalFont = draw_get_font();
var originalColor = draw_get_color();

draw_set_font(fnt_letter_smallest);
draw_set_color(c_white);

var thankYouMessage = global.pizzaOrderEnd;
var messageWidth = string_width(thankYouMessage);
var messageX = (room_width - messageWidth) / 2;
draw_text(messageX, 40, thankYouMessage);

var boxX1 = 766;
var boxY1 = 563;
var boxX2 = 1038;
var boxY2 = 410;

var boxWidth = abs(boxX2 - boxX1);
var cellWidth = boxWidth / max(array_length(global.wordList), 1);
var centerY = (boxY1 + boxY2) / 2;

for (var i = 0; i < array_length(global.wordList); i++) {
    var word = global.wordList[i];
    var objType = ds_map_find_value(global.wordToObjectMap, word);
    
    if (!is_undefined(objType)) {
        var posX = boxX1 + (i + 0.5) * cellWidth;
        var spriteToDraw = object_get_sprite(objType);
        if (sprite_exists(spriteToDraw)) {
            draw_sprite(spriteToDraw, -1, posX, centerY);
        }
    }
}

draw_set_font(originalFont);
draw_set_color(originalColor);
