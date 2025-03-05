centerX = room_width / 2;
centerY = room_height / 2;
outerRadius = min(room_width, room_height) * 0.4;
innerRadius = outerRadius * 0.5;
var numSectors = 5;
var gapAngle = degtorad(5);
var totalGap = numSectors * gapAngle;
var sectorAngle = (2 * pi - totalGap) / numSectors;
var offsetAngle = -pi/2;
buttonList = [
    { text: "Pizza Game",    room: rmPizzaGameStart,    dashStartX: 100, dashEndX: 1510, dashY: 330, numOfActiveWords: 3, sprite: sPizzaGameMenuSprite },
    { text: "Places Game",   room: rmPlacesGame,   dashStartX: 264, dashEndX: 1700, dashY: 500, numOfActiveWords: 1, sprite: sPlacesGameMenuSprite },
    { text: "Role Game",     room: rmRoleGameStart,     dashStartX: 1030, dashEndX: 1790, dashY: 607, numOfActiveWords: 3, sprite: sRoleGameMenuSprite },
    { text: "Shopping Game", room: rmShoppingGameStart, dashStartX: 111, dashEndX: 1360, dashY: 251, numOfActiveWords: 3, sprite: sShoppingGameMenuSprite },
    { text: "Colours Game",  room: rmColourGame,   dashStartX: 264, dashEndX: 1700, dashY: 800, numOfActiveWords: 3, sprite: sColoursGameMenuSprite }
];
buttonData = [];
draw_set_font(fntBritanicBoldMenu);
for (var i = 0; i < array_length_1d(buttonList); i++) {
    var btnInfo = buttonList[i];
    var secStart = offsetAngle + i * (sectorAngle + gapAngle);
    var secEnd = secStart + sectorAngle;
    secStart = (secStart < 0) ? secStart + 2*pi : secStart;
    secEnd   = (secEnd   < 0) ? secEnd   + 2*pi : secEnd;
    var angDiff = (secEnd >= secStart) ? (secEnd - secStart) : ((2*pi - secStart) + secEnd);
    var textAngle = secStart + angDiff/2;
    if (textAngle >= 2*pi) textAngle -= 2*pi;
    array_push(buttonData, {
        text: btnInfo.text,
        room: btnInfo.room,
        dashStartX: btnInfo.dashStartX,
        dashEndX: btnInfo.dashEndX,
        dashY: btnInfo.dashY,
        numOfActiveWords: btnInfo.numOfActiveWords,
        sectorStart: secStart,
        sectorEnd: secEnd,
        textAngle: textAngle,
        sprite: btnInfo.sprite
    });
}
menuRotation = 0;
rotationSpeed = degtorad(0.5);
hoveredIndex = -1;
animFrame = 0;
animation_speed = 0.2;