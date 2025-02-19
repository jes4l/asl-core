draw_set_font(fntBritanicBoldMenu);

for (var i = 0; i < array_length_1d(buttonData); i++) {
    var btn = buttonData[i];
    
    draw_set_alpha(0.4);
    draw_set_color(c_white);
    
    var steps = 10;
    var angDiff = (btn.sectorEnd >= btn.sectorStart) 
                  ? (btn.sectorEnd - btn.sectorStart)
                  : ((2*pi - btn.sectorStart) + btn.sectorEnd);
    var angleStep = angDiff / steps;
    
    for (var j = 0; j < steps; j++) {
        var a1 = btn.sectorStart + j * angleStep;
        var a2 = a1 + angleStep;
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
        var a1 = btn.sectorStart + j * angleStep;
        var a2 = a1 + angleStep;
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
    
    var rx1 = centerX + outerRadius * cos(btn.sectorStart);
    var ry1 = centerY + outerRadius * sin(btn.sectorStart);
    var rx2 = centerX + innerRadius * cos(btn.sectorStart);
    var ry2 = centerY + innerRadius * sin(btn.sectorStart);
    draw_line(rx1, ry1, rx2, ry2);
    
    var rx3 = centerX + outerRadius * cos(btn.sectorEnd);
    var ry3 = centerY + outerRadius * sin(btn.sectorEnd);
    var rx4 = centerX + innerRadius * cos(btn.sectorEnd);
    var ry4 = centerY + innerRadius * sin(btn.sectorEnd);
    draw_line(rx3, ry3, rx4, ry4);
    
    var buttonText = btn.text;
    var len = string_length(buttonText);
    var textRadius = innerRadius + 20;
    
    draw_set_font(fntBritanicBoldMenu);
    
    var totalTextWidth = 0;
    var letterWidths = [];
    for (var k = 1; k <= len; k++) {
        var letter = string_char_at(buttonText, k);
        var lw = string_width(letter);
        array_push(letterWidths, lw);
        totalTextWidth += lw;
    }
    
    var textAngularSpan = totalTextWidth / textRadius;
    
    var sectorMid;
    if (btn.sectorStart <= btn.sectorEnd) {
        sectorMid = (btn.sectorStart + btn.sectorEnd) / 2;
    } else {
        sectorMid = ((btn.sectorStart + (btn.sectorEnd + 2*pi)) / 2) mod (2*pi);
    }
    
    var startAngle = sectorMid - textAngularSpan / 2;
    
    for (var k = 0; k < len; k++) {
        var letterAngularWidth = letterWidths[k] / textRadius;
        var letterCenterAngle = startAngle + letterAngularWidth / 2;
        var tx = centerX + textRadius * cos(letterCenterAngle);
        var ty = centerY + textRadius * sin(letterCenterAngle);
        var rotateDegrees = -radtodeg(letterCenterAngle) - 90;
        
        draw_set_alpha(1);
        draw_set_color(c_white);
        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);
        
        draw_text_transformed(tx, ty, string_char_at(buttonText, k + 1), 1, 1, rotateDegrees);
        
        startAngle += letterAngularWidth;
    }
}

draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_alpha(1);
