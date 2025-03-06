menuRotation += rotationSpeed;
menuRotation = (menuRotation + 2*pi) mod (2*pi);
var m_dx = mouse_x - centerX;
var m_dy = mouse_y - centerY;
var m_dist = sqrt(sqr(m_dx) + sqr(m_dy));
var m_angle = arctan2(m_dy, m_dx);
if (m_angle < 0) m_angle += 2*pi;
var rot_m_angle = (m_angle - menuRotation + 2*pi) mod (2*pi);
var prevHoveredIndex = hoveredIndex;
hoveredIndex = -1;
if (m_dist >= innerRadius && m_dist <= outerRadius) {
    for (var i = 0; i < array_length_1d(buttonData); i++) {
        var btn = buttonData[i];
        if (btn.sectorStart < btn.sectorEnd) {
            if (rot_m_angle >= btn.sectorStart && rot_m_angle <= btn.sectorEnd) {
                hoveredIndex = i;
                break;
            }
        } else {
            if (rot_m_angle >= btn.sectorStart || rot_m_angle <= btn.sectorEnd) {
                hoveredIndex = i;
                break;
            }
        }
    }
}
if (hoveredIndex != prevHoveredIndex) {
    animFrame = 0;
    if (hoveredIndex != -1) {
        var spr = buttonData[hoveredIndex].sprite;
        var spr_speed = sprite_get_speed(spr);
        var spr_speed_type = sprite_get_speed_type(spr);
        if (spr_speed_type == spritespeed_framespersecond) {
            animation_speed = spr_speed / room_speed;
        } else {
            animation_speed = spr_speed;
        }
    }
} else if (hoveredIndex != -1) {
    animFrame += animation_speed;
}
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
					global.chosenSprite = -1;
					global.scoreGained = 0;
					global.oRoleGameSprites = undefined;
                    room_goto(btn.room);
                    break;
                }
            } else {
                if (clickAngle >= btn.sectorStart || clickAngle <= btn.sectorEnd) {
                    scrUpdateWordList(btn.text, btn.numOfActiveWords);
                    global.dashStartX = btn.dashStartX;
                    global.dashEndX   = btn.dashEndX;
                    global.dashY      = btn.dashY;
					global.chosenSprite = -1;
					global.scoreGained = 0;
					global.oRoleGameSprites = undefined;
                    room_goto(btn.room);
                    break;
                }
            }
        }
    }
}