// oClock - Draw Event

/// @description Draws the remaining time with a dynamic font based on the current room

if (room == rmShoppingGame) {
    draw_set_font(fntSevenSegment);
}
else if (room == rmPizzaGame) {
    draw_set_font(fntSevenSegment);
}
else if (room == rmPlacesGame) {
    draw_set_font(fntClock);
}
else if (room == rmColourGame) {
    draw_set_font(fntClock);
}
else if (room == rmRoleGame) {
    draw_set_font(fntClock);
}
else {
    draw_set_font(fntClock);
}

// **Set Other Drawing Properties**
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_color(c_white);
draw_set_alpha(1);

// **Draw the Remaining Time**
draw_text(x, y, string(floor(timeLeft)));
