function draw_rounded_rect(x1, y1, x2, y2, radius, filled=true) {
    if (filled) {
        draw_rectangle(x1 + radius, y1, x2 - radius, y2, false);
        draw_circle(x1 + radius, y1 + radius, radius, false);
        draw_circle(x2 - radius, y1 + radius, radius, false);
        draw_rectangle(x1, y1 + radius, x1 + radius, y2 - radius, false);
        draw_rectangle(x2 - radius, y1 + radius, x2, y2 - radius, false);
    } else {

        draw_rectangle(x1 + radius, y1, x2 - radius, y1 + 1, false);
        draw_rectangle(x1 + radius, y2 - 1, x2 - radius, y2, false);
        draw_rectangle(x1, y1 + radius, x1 + 1, y2 - radius, false);
        draw_rectangle(x2 - 1, y1 + radius, x2, y2 - radius, false);
        
        draw_circle(x1 + radius, y1 + radius, radius, false);
        draw_circle(x2 - radius, y1 + radius, radius, false);
        draw_circle(x1 + radius, y2 - radius, radius, false);
        draw_circle(x2 - radius, y2 - radius, radius, false);
    }
}

draw_set_color(c_black);
draw_rounded_rect(bgX, bgY, bgX + barWidth, bgY + barHeight, radius);

draw_set_color(c_black);
draw_rounded_rect(bgX, bgY, bgX + barWidth, bgY + barHeight, radius, false);

var fillWidth = progress * barWidth;
if (fillWidth > 0) {
    draw_set_color(c_green);
    draw_rounded_rect(bgX, bgY, bgX + fillWidth, bgY + barHeight, radius);
}

scrDrawText(room_width / 2, textYMain, textMain, c_white, 1, fontBold);
scrDrawText(room_width / 2, textYSub, textSub, c_white, 1, fontSmall);
