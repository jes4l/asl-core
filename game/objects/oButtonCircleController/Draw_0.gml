var textRadius = (innerRadius + outerRadius) / 2;
for (var i = 0; i < array_length_1d(buttonData); i++) {
    var btn = buttonData[i];
    var isHovered = (i == hoveredIndex);
    var rotSectorStart = (btn.sectorStart + menuRotation + 2*pi) mod (2*pi);
    var rotSectorEnd   = (btn.sectorEnd   + menuRotation + 2*pi) mod (2*pi);
    var sectorColor = isHovered ? c_white : c_gray;
    var textColor = isHovered ? make_color_rgb(80,80,80) : c_white;
    draw_set_alpha(isHovered ? 0.8 : 0.4);
    draw_set_color(sectorColor);
    var steps = 20;
    var angDiff = (rotSectorEnd >= rotSectorStart) ? (rotSectorEnd - rotSectorStart) : ((2*pi - rotSectorStart) + rotSectorEnd);
    var angleStep = angDiff / steps;
    for (var j = 0; j < steps; j++) {
        var a1 = rotSectorStart + j * angleStep;
        var a2 = rotSectorStart + (j + 1) * angleStep;
        var ox1 = centerX + outerRadius * cos(a1);
        var oy1 = centerY + outerRadius * sin(a1);
        var ox2 = centerX + outerRadius * cos(a2);
        var oy2 = centerY + outerRadius * sin(a2);
        var ix1 = centerX + innerRadius * cos(a1);
        var iy1 = centerY + innerRadius * sin(a1);
        var ix2 = centerX + innerRadius * cos(a2);
        var iy2 = centerY + innerRadius * sin(a2);
        draw_primitive_begin(pr_trianglelist);
            draw_vertex(ox1, oy1);
            draw_vertex(ox2, oy2);
            draw_vertex(ix1, iy1);
        draw_primitive_end();
        draw_primitive_begin(pr_trianglelist);
            draw_vertex(ix1, iy1);
            draw_vertex(ox2, oy2);
            draw_vertex(ix2, iy2);
        draw_primitive_end();
    }
    draw_set_alpha(1);
    draw_set_color(c_black);
    for (var j = 0; j < steps; j++) {
        var a1 = rotSectorStart + j * angleStep;
        var a2 = rotSectorStart + (j + 1) * angleStep;
        var ox1 = centerX + outerRadius * cos(a1);
        var oy1 = centerY + outerRadius * sin(a1);
        var ox2 = centerX + outerRadius * cos(a2);
        var oy2 = centerY + outerRadius * sin(a2);
        var ix1 = centerX + innerRadius * cos(a1);
        var iy1 = centerY + innerRadius * sin(a1);
        var ix2 = centerX + innerRadius * cos(a2);
        var iy2 = centerY + innerRadius * sin(a2);
        draw_line(ox1, oy1, ox2, oy2);
        draw_line(ix1, iy1, ix2, iy2);
    }
    var rx1 = centerX + outerRadius * cos(rotSectorStart);
    var ry1 = centerY + outerRadius * sin(rotSectorStart);
    var rx2 = centerX + innerRadius * cos(rotSectorStart);
    var ry2 = centerY + innerRadius * sin(rotSectorStart);
    draw_line(rx1, ry1, rx2, ry2);
    var rx3 = centerX + outerRadius * cos(rotSectorEnd);
    var ry3 = centerY + outerRadius * sin(rotSectorEnd);
    var rx4 = centerX + innerRadius * cos(rotSectorEnd);
    var ry4 = centerY + innerRadius * sin(rotSectorEnd);
    draw_line(rx3, ry3, rx4, ry4);
    var buttonText = btn.text;
    var len = string_length(buttonText);
    var totalTextWidth = 0;
    var letterWidths = [];
    var padding = 2;
    for (var k = 1; k <= len; k++) {
        var letter = string_char_at(buttonText, k);
        var lw = string_width(letter) + padding;
        array_push(letterWidths, lw);
        totalTextWidth += lw;
    }
    var textAngularSpan = totalTextWidth / textRadius;
    var sectorMid = (rotSectorStart <= rotSectorEnd) ? (rotSectorStart + rotSectorEnd) / 2 : (((rotSectorStart + (rotSectorEnd + 2*pi)) / 2) mod (2*pi));
    var startAngle = sectorMid - textAngularSpan / 2;
    for (var k = 0; k < len; k++) {
        var letterAngularWidth = letterWidths[k] / textRadius;
        var letterCenterAngle = startAngle + letterAngularWidth / 2;
        var tx = centerX + textRadius * cos(letterCenterAngle);
        var ty = centerY + textRadius * sin(letterCenterAngle);
        var rotateDegrees = -radtodeg(letterCenterAngle) - 90;
        draw_set_alpha(1);
        draw_set_color(textColor);
        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);
        draw_text_transformed(tx, ty, string_char_at(buttonText, k + 1), 1, 1, rotateDegrees);
        startAngle += letterAngularWidth;
    }
}
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_alpha(1);
if (hoveredIndex != -1) {
    var spr = buttonData[hoveredIndex].sprite;
    var numFrames = sprite_get_number(spr);
    var subimg = floor(animFrame) % numFrames;
    draw_sprite(spr, subimg, centerX, centerY);
} else {
    draw_sprite(sASLCoreLogoMenu, 0, centerX, centerY);
}