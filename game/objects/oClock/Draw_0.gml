/// oClock - Draw Event

draw_set_font(fntClock);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_color(c_white);
draw_set_alpha(1);

// Draw the time left
draw_text(x, y, string(timeLeft));
