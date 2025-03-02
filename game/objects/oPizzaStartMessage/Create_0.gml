timeRemainingText = "Hi There, I Am Hungry And\n I Need You To Create A Pizza With: ";
textX = 590;
textY = 220;
fontToUse = fntSevenSegmentMessagePizza;
textColor = c_white;
textAlpha = 1;
pizzaBase = instance_find(oPizzaBase, 0);
totalPoints = 6;
points = array_create(totalPoints);
var startX = 272;
var startY = 800;
var endX = 1920;
var endY = 800;
for (var i = 0; i < totalPoints; i++){
    var t = i / (totalPoints - 1);
    points[i] = { x: lerp(startX, endX, t), y: lerp(startY, endY, t) };
}
currentPoint = 0;
if (pizzaBase != noone){
    pizzaBase.x = points[currentPoint].x;
    pizzaBase.y = points[currentPoint].y;
}
isMoving = false;
topMessages = ["Top message 0", "Top message 1", "Top message 2", "Top message 3", "Top message 4", "Top message 5"];
bottomMessages = ["Bottom message 0", "Bottom message 1", "Bottom message 2", "Bottom message 3", "Bottom message 4", "Bottom message 5"];
