draw_set_color(c_white);
var letterSprite = scrGetASLSprite(global.currentWordLetters[0]);
var dashLetterX = (room_width / 2) - 350;
var dashLetterY = global.dashY;
if (letterSprite != -1) {
    var sprW = sprite_get_width(letterSprite);
    var sprH = sprite_get_height(letterSprite);
    draw_sprite(letterSprite, 0, dashLetterX - sprW / 2, dashLetterY - sprH / 2);
} else {
    draw_set_font(fntSevenSegment100);
    draw_set_color(c_white);
    draw_text(dashLetterX, dashLetterY, global.currentWordLetters[0]);
}
var overlayX = (((room_width / 2) + 350) + (room_width - 350)) / 2;
var overlayY = (room_height / 2 + 200) - 80;
if (overlayLetter != "") {
    var expectedLetter = global.currentWordLetters[0];
    draw_set_font(fntOpenSans80);
    if (overlayLetter == expectedLetter) {
        draw_set_color(c_green);
        draw_set_alpha(1);
        draw_text(overlayX, overlayY, expectedLetter);
    } else {
        draw_set_color(c_red);
        draw_set_alpha(fadeAlpha);
        draw_text(overlayX, overlayY, overlayLetter);
        draw_set_alpha(1);
    }
}

draw_set_color(c_white);
draw_set_font(fntOpenSans40);
draw_set_halign(fa_left);
draw_text(251, 340, "Sign the Letter: " + global.currentWordLetters[0]);
draw_text(251, 400, "Green is Accurate, Orange is Moderate, Red is Inaccurate");
draw_set_color(-1);
draw_set_font(-1);
draw_set_halign(-1);
