menuRotation += rotationSpeed;
menuRotation = (menuRotation + 2*pi) mod (2*pi);

if (mouse_check_button_pressed(mb_left)) {
    var dx = mouse_x - centerX;
    var dy = mouse_y - centerY;
    var dist = sqrt(sqr(dx) + sqr(dy));
    
    if (dist >= innerRadius && dist <= outerRadius) {
        var clickAngle = arctan2(dy, dx);
        if (clickAngle < 0) clickAngle += 2*pi;
        
        clickAngle = (clickAngle - menuRotation + 2*pi) mod (2*pi);
        
        for (var i = 0; i < array_length_1d(buttonData); i++) {
            var btn = buttonData[i];
            if (btn.sectorStart < btn.sectorEnd) {
                if (clickAngle >= btn.sectorStart && clickAngle <= btn.sectorEnd) {
                    scrUpdateWordList(btn.text, btn.numOfActiveWords);
                    global.dashStartX = btn.dashStartX;
                    global.dashEndX   = btn.dashEndX;
                    global.dashY      = btn.dashY;
                    room_goto(btn.room);
                    break;
                }
            } else {
                if (clickAngle >= btn.sectorStart || clickAngle <= btn.sectorEnd) {
                    scrUpdateWordList(btn.text, btn.numOfActiveWords);
                    global.dashStartX = btn.dashStartX;
                    global.dashEndX   = btn.dashEndX;
                    global.dashY      = btn.dashY;
                    room_goto(btn.room);
                    break;
                }
            }
        }
    }
}