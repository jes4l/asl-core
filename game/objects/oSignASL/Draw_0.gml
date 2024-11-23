draw_self();

function drawCenteredText(x, y, text, font) {
    var originalFont = draw_get_font();
    draw_set_font(font);
    var textWidth = string_width(text);
    var textHeight = string_height(text);
    var displayX = x - (textWidth / 2);
    var displayY = y - (textHeight / 2);
    draw_text(displayX, displayY, text);
    draw_set_font(originalFont);
}

function drawCenteredSprite(x, y, sprite) {
    var spriteWidth = sprite_get_width(sprite);
    var spriteHeight = sprite_get_height(sprite);
    var displayX = x - (spriteWidth / 2);
    var displayY = y - (spriteHeight / 2);
    draw_sprite(sprite, 0, displayX, displayY);
}

draw_set_color(c_black);

var signText = "Sign";
var signFont = fnt_letter_smallest;
var signX = x + (bbox_right - bbox_left) / 2;
var signY = y + (bbox_bottom - bbox_top) * 0.1;
drawCenteredText(signX, signY, signText, signFont);

function getASLSignSprite(letter) {
    var aslSignName = "s" + string_upper(letter); // Look for a sprite like sA, sB, etc.
    var aslSignSprite = asset_get_index(aslSignName);
    return (aslSignSprite != -1) ? aslSignSprite : -1; // Return sprite index or -1 if not found
}

var nextLetter = getNextLetter(global.letterList, global.targetWord);
var aslSignSprite = getASLSignSprite(nextLetter);

if (aslSignSprite != -1) {
    var letterX = x + (bbox_right - bbox_left) / 2;
    var letterY = y + (bbox_bottom - bbox_top) / 2;
    drawCenteredSprite(letterX, letterY, aslSignSprite);
}

draw_set_color(-1);
