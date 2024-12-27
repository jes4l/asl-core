var buttonMinWidthRatio  = 0.2;
var buttonMaxWidthRatio = 0.5;
var buttonHeightRatio    = 0.10;
var buttonPaddingRatio    = 0.02;

var minButtonWidth = room_width  * buttonMinWidthRatio;
var maxButtonWidth = room_width  * buttonMaxWidthRatio;
var buttonHeight   = room_height * buttonHeightRatio;
buttonPadding      = room_width  * buttonPaddingRatio;

buttonList = [
    { text: "Pizza Game",    room: rmPizzaGame,    x: 0.1, y: 0.2 },
    { text: "Places Game",   room: rmPlacesGame,   x: 0.1, y: 0.4 },
    { text: "Role Game",     room: rmRoleGame,     x: 0.1, y: 0.6 },
    { text: "Shopping Game", room: rmShoppingGame, x: 0.6, y: 0.2 },
    { text: "Colours Game",  room: rmColourGame,   x: 0.6, y: 0.4 }
];

buttonData = [];
draw_set_font(fntButton);

for (var i = 0; i < array_length(buttonList); i++) {
    var btnInfo = buttonList[i];
    var textWidth = string_width(btnInfo.text);
    var desiredWidth = textWidth + (2 * buttonPadding);
    desiredWidth = clamp(desiredWidth, minButtonWidth, maxButtonWidth);

    var x1 = room_width  * btnInfo.x;
    var y1 = room_height * btnInfo.y;

    var x2 = x1 + desiredWidth;
    var y2 = y1 + buttonHeight;

    array_push(buttonData, {
        text:   btnInfo.text,
        room:   btnInfo.room,
        x1:     x1,
        y1:     y1,
        x2:     x2,
        y2:     y2,
        width:  desiredWidth,
        height: buttonHeight
    });
}
