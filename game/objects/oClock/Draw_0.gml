var originalColor = draw_get_color();
var originalFont = draw_get_font();

draw_set_color(c_white);
draw_circle(clockCenterX, clockCenterY, clockRadius, false);

var percentLeft = timerCurrent / timerDuration;
var startAngle = -270;
var endAngle = startAngle - percentLeft * 360;

draw_set_color(make_color_hsv(120 * percentLeft, 1, 1));

var segments = 50;
var angleStep = (endAngle - startAngle) / segments;
for (var i = 0; i < segments; i++) {
    var angle1 = startAngle + i * angleStep;
    var angle2 = startAngle + (i + 1) * angleStep;

    var x1 = clockCenterX + lengthdir_x(clockRadius, angle1);
    var y1 = clockCenterY + lengthdir_y(clockRadius, angle1);
    var x2 = clockCenterX + lengthdir_x(clockRadius, angle2);
    var y2 = clockCenterY + lengthdir_y(clockRadius, angle2);

    draw_triangle(clockCenterX, clockCenterY, x1, y1, x2, y2, false);
}

var divisions = 12;
draw_set_color(c_gray);
for (var i = 0; i < divisions; i++) {
    var angle = i * 360 / divisions;
    var x1 = clockCenterX + lengthdir_x(clockRadius - 5, angle);
    var y1 = clockCenterY + lengthdir_y(clockRadius - 5, angle);
    var x2 = clockCenterX + lengthdir_x(clockRadius, angle);
    var y2 = clockCenterY + lengthdir_y(clockRadius, angle);
    draw_line(x1, y1, x2, y2);
}

var handAngle = startAngle - percentLeft * 360;
draw_set_color(c_red);
var handX = clockCenterX + lengthdir_x(handLength, handAngle);
var handY = clockCenterY + lengthdir_y(handLength, handAngle);
draw_line_width(clockCenterX, clockCenterY, handX, handY, 3);

draw_set_color(c_black);
var timeText = string(floor(timerCurrent));
draw_text(clockCenterX - string_width(timeText) / 2, clockCenterY - string_height("0") / 2, timeText);

draw_set_color(originalColor);
draw_set_font(originalFont);