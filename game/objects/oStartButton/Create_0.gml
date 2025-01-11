// oStartButton - Create Event

buttonText = "Start";
buttonPadding = 15;

var margin = 10;

draw_set_font(fntButton);
var textWidth  = string_width(buttonText);
var textHeight = string_height(buttonText);

buttonWidth  = textWidth  + (buttonPadding * 2);
buttonHeight = textHeight + (buttonPadding * 2);

x1 = room_width  - margin - buttonWidth;
y1 = room_height - margin - buttonHeight;
x2 = x1 + buttonWidth;
y2 = y1 + buttonHeight;
