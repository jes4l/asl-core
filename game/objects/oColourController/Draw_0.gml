for (var i = 0; i < 4; i++) {
    var slot = slots[i];
    if (slot.sprite != -1) {
        draw_sprite_ext(slot.sprite, 0, slot.x, slot.y, 1, 1, 0, c_white, 1);
    }
}
var displayX = 1340;
var displayY = 150;
draw_set_color(c_white);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
if (global.gameComplete) {
    draw_text(displayX, displayY, "Mixing");
} else {
    draw_set_font(fntSevenSegment80);
    if (feedbackMessage != "") {
        draw_text(displayX, displayY, feedbackMessage);
    } else {
        draw_set_font(fntSevenSegment50);
        draw_text(displayX, displayY, "Select the correct test tube");
    }
}