var progress = elapsedTime / loadingDuration;
var barFillWidth = barWidth * progress;

draw_set_color(c_black);
draw_rectangle(x1, y1, x1 + barWidth, y1 + barHeight, false);
draw_set_color(c_white);
draw_rectangle(x1, y1, x1 + barFillWidth, y1 + barHeight, true);

draw_set_font(fnt_letter);
draw_set_color(c_white);
draw_text(centerTextX, centerTextY, centerText);

draw_set_font(fnt_letter_smallest);
draw_set_color(c_white);
draw_text(loadingTextX, loadingTextY, loadingText);
