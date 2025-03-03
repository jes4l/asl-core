textX = 590;
textY = 220;
fontToUse = fntSevenSegmentMessagePizza;
textColor = c_white;
textAlpha = 1;
basket = instance_find(oBasket, 0);
totalPoints = 6;
points = array_create(totalPoints);
var startX = 267;
var startY = 695;
var endX = startX + 1648;
var endY = startY;
for (var i = 0; i < totalPoints; i++) {
    var t = i / (totalPoints - 1);
    points[i] = { x: lerp(startX, endX, t), y: lerp(startY, endY, t) };
}
currentPoint = 0;
if (basket != noone) {
    basket.x = points[currentPoint].x;
    basket.y = points[currentPoint].y;
    basket.image_xscale = 1.24217;
    basket.image_yscale = 1.24217;
}
isMoving = false;
topMessages = [
    "Top message 0",
    "Top message 1",
    "Top message 2",
    "Top message 3",
    "Top message 4",
    "Top message 5"
];
bottomMessages = [
    "Bottom message 0",
    "Bottom message 1",
    "Bottom message 2",
    "Bottom message 3",
    "Bottom message 4",
    "Bottom message 5"
];
