if (mouse_check_button_pressed(mb_left)) {
    for (var i = 0; i < array_length(buttonData); i++) {
        var btn = buttonData[i];
        if (point_in_rectangle(mouse_x, mouse_y, btn.x1, btn.y1, btn.x2, btn.y2)) {
            scrUpdateWordList(btn.text);
            global.dashStartX = btn.dashStartX;
            global.dashEndX   = btn.dashEndX;
            global.dashY      = btn.dashY;
            room_goto(btn.room);
            break;
        }
    }
}
