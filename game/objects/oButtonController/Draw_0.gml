draw_set_font(fntButton);

for (var i = 0; i < array_length(buttonData); i++) {
    var btn = buttonData[i];
    draw_set_color(c_black);
    draw_rectangle(btn.x1, btn.y1, btn.x2, btn.y2, false);
    draw_set_color(c_white);
    draw_rectangle(btn.x1, btn.y1, btn.x2, btn.y2, true);
    var textX = btn.x1 + buttonPadding;
    var textY = btn.y1 + (btn.height - string_height(btn.text)) / 2;
    draw_set_color(c_white);
    draw_text(textX, textY, btn.text);
}
