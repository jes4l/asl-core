draw_set_font(fontToUse);
draw_set_alpha(textAlpha);
draw_set_color(textColor);
draw_text(textX, textY, timeRemainingText);

var labelText = "Server Status: ";
var statusText = string(global.connectionStatus);
draw_set_color(textColor);
//draw_text(textX, textY + 40, labelText);
var labelWidth = string_width(labelText);
if (global.connectionStatus == "Disconnected") {
    draw_set_color(c_red);
} else {
    draw_set_color(c_green);
}
//draw_text(textX + labelWidth, textY + 40, statusText);
