draw_set_color(c_white);

var letterSprite = scrGetASLSprite(global.currentWordLetters[0]);

var letterX = (room_width / 2) - 350;
var letterY = global.dashY;

if (letterSprite != -1) {
    var sprW = sprite_get_width(letterSprite);
    var sprH = sprite_get_height(letterSprite);
    draw_sprite(letterSprite, 0, letterX - sprW / 2, letterY - sprH / 2);
} else {
    draw_set_font(fntSevenSegment100);
    draw_set_color(c_white);
    draw_text(letterX, letterY, global.currentWordLetters[0]);
}
