var numButtons = 5;
var offsetAngle = -90;
var sectorAngle = 360 / numButtons;

centerX = room_width / 2;
centerY = room_height / 2;

outerRadius = min(room_width, room_height) * 0.4;
innerRadius = outerRadius * 0.5;

buttonList = [
    { text: "Pizza Game",    room: rmPizzaGame,    dashStartX: 100, dashEndX: 1510, dashY: 330, numOfActiveWords: 3 },
    { text: "Places Game",   room: rmPlacesGame,   dashStartX: 264, dashEndX: 1700, dashY: 500, numOfActiveWords: 1 },
    { text: "Role Game",     room: rmRoleGame,     dashStartX: 1030, dashEndX: 1790, dashY: 607, numOfActiveWords: 3 },
    { text: "Shopping Game", room: rmShoppingGame, dashStartX: 111, dashEndX: 1360, dashY: 251, numOfActiveWords: 3 },
    { text: "Colours Game",  room: rmColourGame,   dashStartX: 264, dashEndX: 1700, dashY: 800, numOfActiveWords: 3 }
];

buttonData = [];
draw_set_font(fntButton);

for (var i = 0; i < array_length_1d(buttonList); i++) {
    var btnInfo = buttonList[i];
    var aStart = offsetAngle + (i * sectorAngle);
    var aEnd = aStart + sectorAngle;
    aStart = (aStart + 360) mod 360;
    aEnd = (aEnd + 360) mod 360;
    
    array_push(buttonData, {
        text: btnInfo.text,
        room: btnInfo.room,
        dashStartX: btnInfo.dashStartX,
        dashEndX: btnInfo.dashEndX,
        dashY: btnInfo.dashY,
        numOfActiveWords: btnInfo.numOfActiveWords,
        angleStart: aStart,
        angleEnd: aEnd
    });
}