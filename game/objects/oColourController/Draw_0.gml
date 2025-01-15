// oColourController - Draw Event

/// @description Draws the 4 sprites at their positions, plus any feedback message

// 1) Draw the slots
for (var i = 0; i < array_length_1d(slots); i++) {
    var slot = slots[i];
    if (slot.sprite != -1) {
        draw_sprite_ext(slot.sprite, 0, slot.x, slot.y, 1, 1, 0, c_white, 1);
    }
}

// 2) If there's a feedback message, draw it at e.g. top-center
if (feedbackMessage != "") {
    draw_set_font(fntWord);
    draw_set_color(c_white);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);

    var displayX = room_width / 2;
    var displayY = 100; // top-center
    draw_text(displayX, displayY, feedbackMessage);
}
