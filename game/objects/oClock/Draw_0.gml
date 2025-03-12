if (room == rmShoppingGame) {
    draw_set_font(fntSevenSegment80);
}
else if (room == rmPizzaGame) {
    draw_set_font(fntSevenSegment80);
}
else if (room == rmPlacesGame) {
    draw_set_font(fntSevenSegment80);
}
else if (room == rmRoleGame) {
    draw_set_font(fntSevenSegment80);
}
else {
    draw_set_font(fntSevenSegment80);
}

draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_color(c_white);
draw_set_alpha(1);

draw_text(x, y, string(floor(timeLeft)));
