if (mouse_check_button_pressed(mb_left)) {
    var dx = mouse_x - centerX;
    var dy = mouse_y - centerY;
    var dist = sqrt(sqr(dx) + sqr(dy));
    
    if (dist >= innerRadius && dist <= outerRadius) {
        var mouseAngle = point_direction(centerX, centerY, mouse_x, mouse_y);
        mouseAngle = (mouseAngle + 360) mod 360;
        
        for (var i = 0; i < array_length_1d(buttonData); i++) {
            var btn = buttonData[i];
            var inSector = false;
            
            if (btn.angleStart < btn.angleEnd) {
                if (mouseAngle >= btn.angleStart && mouseAngle <= btn.angleEnd) inSector = true;
            } else {
                if (mouseAngle >= btn.angleStart || mouseAngle <= btn.angleEnd) inSector = true;
            }
            
            if (inSector) {
                scrUpdateWordList(btn.text, btn.numOfActiveWords);
                global.dashStartX = btn.dashStartX;
                global.dashEndX = btn.dashEndX;
                global.dashY = btn.dashY;
                room_goto(btn.room);
                break;
            }
        }
    }
}