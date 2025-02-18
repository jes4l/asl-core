draw_set_alpha(0.5);
draw_set_font(fntBritanicBoldSmall);
var segments = 36;

for (var i = 0; i < array_length_1d(buttonData); i++) {
    var btn = buttonData[i];
    
    var polyPoints = [];
    var angleDiff = btn.angleEnd - btn.angleStart;
    if (angleDiff < 0) angleDiff += 360;
    var stepSize = angleDiff / segments;

    for (var j = 0; j <= segments; j++) {
        var a = (btn.angleStart + j * stepSize) mod 360;
        var vx = centerX + lengthdir_x(outerRadius, a);
        var vy = centerY + lengthdir_y(outerRadius, a);
        array_push(polyPoints, { x: vx, y: vy });
    }

    for (var j = segments; j >= 0; j--) {
        var a = (btn.angleStart + j * stepSize) mod 360;
        var vx = centerX + lengthdir_x(innerRadius, a);
        var vy = centerY + lengthdir_y(innerRadius, a);
        array_push(polyPoints, { x: vx, y: vy });
    }

    array_push(polyPoints, polyPoints[0]);

    draw_set_color(c_white);
    draw_primitive_begin(pr_trianglefan);
    for (var k = 0; k < array_length_1d(polyPoints); k++) {
        draw_vertex(polyPoints[k].x, polyPoints[k].y);
    }
    draw_primitive_end();

    draw_set_alpha(1);
    draw_set_color(c_white);

    for (var j = 0; j < segments; j++) {
        var a1 = (btn.angleStart + j * stepSize) mod 360;
        var a2 = (btn.angleStart + (j + 1) * stepSize) mod 360;
        draw_line(
            centerX + lengthdir_x(outerRadius, a1),
            centerY + lengthdir_y(outerRadius, a1),
            centerX + lengthdir_x(outerRadius, a2),
            centerY + lengthdir_y(outerRadius, a2)
        );
    }

    for (var j = 0; j < segments; j++) {
        var a1 = (btn.angleStart + j * stepSize) mod 360;
        var a2 = (btn.angleStart + (j + 1) * stepSize) mod 360;
        draw_line(
            centerX + lengthdir_x(innerRadius, a1),
            centerY + lengthdir_y(innerRadius, a1),
            centerX + lengthdir_x(innerRadius, a2),
            centerY + lengthdir_y(innerRadius, a2)
        );
    }

    var xOuterStart = centerX + lengthdir_x(outerRadius, btn.angleStart);
    var yOuterStart = centerY + lengthdir_y(outerRadius, btn.angleStart);
    var xInnerStart = centerX + lengthdir_x(innerRadius, btn.angleStart);
    var yInnerStart = centerY + lengthdir_y(innerRadius, btn.angleStart);
    draw_line(xInnerStart, yInnerStart, xOuterStart, yOuterStart);

    var buttonText = btn.text;
    var len = string_length(buttonText);
    angleDiff = btn.angleEnd - btn.angleStart;
    if (angleDiff < 0) angleDiff += 360;

    var totalTextAngle = angleDiff * 0.8;
    var startTextAngle = btn.angleStart + (angleDiff - totalTextAngle) / 2;
    var charAngleStep = totalTextAngle / max(len - 1, 1);
    var textRadius = innerRadius + 20;

    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_color(c_black);

    for (var c = 0; c < len; c++) {
        var char = string_char_at(buttonText, c + 1);
        var charAngle = startTextAngle + c * charAngleStep;
        charAngle = (charAngle + 360) mod 360;
        
        var tx = centerX + lengthdir_x(textRadius, charAngle);
        var ty = centerY + lengthdir_y(textRadius, charAngle);
        draw_text_transformed(tx, ty, char, 1, 1, charAngle + 90);
    }

    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    
    draw_set_alpha(0.5);
}
