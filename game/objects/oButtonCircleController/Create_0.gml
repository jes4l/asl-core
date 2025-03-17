centerX = room_width / 2;
centerY = (room_height / 2) - 90;
outerRadius = min(room_width, room_height) * 0.4;
innerRadius = outerRadius * 0.55;
var numSectors = 5;
var gapAngle = degtorad(3);
var totalGap = numSectors * gapAngle;
var sectorAngle = (2 * pi - totalGap) / numSectors;
var offsetAngle = -pi/2;

buttonList = [
    { text: "Places Game", description: "A customer will finger spell the destination. You must memorise and drive by switching lanes to the location.\n Tests your memory by recalling which places signs corresponds to the letter.", room: rmPlacesGameStart, dashStartX: 264, dashEndX: 1700, dashY: 500, numOfActiveWords: 1, sprite: sPlacesGameMenuSprite },
    { text: "Colours Game", description: "A Scientist will finger spell names of the coloured test tube. You must select the correct test tube to mix.\n Test retaining and recalling the names of the colours.", room: rmColourGameStart, dashStartX: 264, dashEndX: 1700, dashY: 800, numOfActiveWords: 3, sprite: sColoursGameMenuSprite },
    { text: "Ingredients Game", description: "You must sign the letters of the ingredients on a pizza ingredients within a time frame. You will be given the ASL Sign to mimic.\n Tests your ability to sign ASL correctly and accurately.", room: rmPizzaGameStart, dashStartX: 100, dashEndX: 1510, dashY: 380, numOfActiveWords: 3, sprite: sPizzaGameMenuSprite },
    { text: "Role Game", description: "You must sign the role of the customer to fill in a Tax Form. The customer will sign you there role. Tests your ability to sign ASL correctly and accurately within a time frame.", room: rmRoleGameStart, dashStartX: 1030, dashEndX: 1790, dashY: 607, numOfActiveWords: 3, sprite: sRoleGameMenuSprite },
    { text: "Shopping Game", description: "You are a cashier and must sign the name of the items before they reach the end of the conveyor belt. You will not be given any ASL Signs. Tests accuracy and remebering the ASL signs.", room: rmShoppingGameStart, dashStartX: 111, dashEndX: 1360, dashY: 251, numOfActiveWords: 3, sprite: sShoppingGameMenuSprite }
];
buttonData = [];

for (var i = 0; i < array_length_1d(buttonList); i++) {
    var btnInfo = buttonList[i];
    var secStart = offsetAngle + i * (sectorAngle + gapAngle);
    var secEnd = secStart + sectorAngle;
    secStart = (secStart < 0) ? secStart + 2*pi : secStart;
    secEnd = (secEnd < 0) ? secEnd + 2*pi : secEnd;
    array_push(buttonData, {
        text: btnInfo.text,
        description: btnInfo.description,
        room: btnInfo.room,
        dashStartX: btnInfo.dashStartX,
        dashEndX: btnInfo.dashEndX,
        dashY: btnInfo.dashY,
        numOfActiveWords: btnInfo.numOfActiveWords,
        sectorStart: secStart,
        sectorEnd: secEnd,
        sprite: btnInfo.sprite
    });
}

menuRotation = 0;
hoveredIndex = -1;
animFrame = 0;
animation_speed = 0;