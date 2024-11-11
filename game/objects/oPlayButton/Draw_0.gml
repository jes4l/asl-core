var progress = elapsedTime / loadingDuration;
var barFillWidth = barWidth * progress;

draw_set_color(c_black);
draw_rectangle(x1, y1, x1 + barWidth, y1 + barHeight, false);
draw_set_color(c_green);
draw_rectangle(x1, y1, x1 + barFillWidth, y1 + barHeight, true);

var textX = x1 + barPadding;
var textY = y1 + (barHeight - textHeight) / 2;
draw_set_color(c_white);

var revealWidth = barFillWidth - barPadding * 2;
if (revealWidth > 0) {
    var revealText = string_copy(loadingText, 1, floor(string_length(loadingText) * (revealWidth / textWidth)));
    draw_text(textX, textY, revealText);
}
