var count = array_length(lettersToDisplay);
var spriteY = room_height / 3 + 350;
var text_height = string_height("A");
var offset = -100;

draw_set_color(c_white);
draw_set_font(fntOpenSans40);
draw_set_halign(fa_left);
draw_text(251, 340, global.showWorst ? "Target Letters:" : "Best Performed Letters:");

draw_set_font(fntOpenSans80);
draw_set_valign(fa_middle);
draw_set_halign(fa_center);

for (var i = 0; i < count; i++) {
    var letter = lettersToDisplay[i].letter;
    var posX = (i + 0.5) * (room_width / count);
    var spriteX = posX + 125;
    var spriteIndex = scrGetASLSprite(letter);
    var alpha = alphaArray[i];

    gpu_set_blendmode(bm_normal);
    draw_set_alpha(alpha);

    if (spriteIndex != -1) {
        var sprW = sprite_get_width(spriteIndex);
        var sprH = sprite_get_height(spriteIndex);
        var spriteDrawY = spriteY - sprH / 2;
        draw_sprite(spriteIndex, 0, spriteX - sprW / 2, spriteDrawY);
        var textY = spriteY + sprH / 2 + offset + text_height / 2;
        draw_text(posX, textY, letter);
    } else {
        draw_text(posX, spriteY, letter);
    }
}

draw_set_alpha(1);