textX = 590;
textY = 220;
fontToUse = fntSevenSegment40;
textColor = c_white;
textAlpha = 1;
pizzaBase = instance_find(oPizzaBase, 0);
totalPoints = 5;
points = array_create(totalPoints);
var startX = 272;
var startY = 784;
var endX = 1920;
var endY = 784;
for (var i = 0; i < totalPoints; i++) {
    var t = i / (totalPoints - 1);
    points[i] = { x: lerp(startX, endX, t), y: lerp(startY, endY, t) };
}
currentPoint = 0;
if (pizzaBase != noone) {
    pizzaBase.x = points[currentPoint].x;
    pizzaBase.y = points[currentPoint].y;
}
isMoving = false;
topMessages = [
    "Hi There, I Am Hungry And\n I Need You To Create A Pizza With: ",
    "Let Me Teach You How To Add The\n Ingredients",
    "Sign The Current Letter For The\n Ingredients Shown On The Ticket",
    "Do Not Worry The ASL Display Will\n Help You Learn",
    "Your Sign Accuracy Determines Your\n Tips. Do not Let the Timer Run Out"
];
bottomMessages = [
    "",
    "You Got To Use Sign Language",
    "",
    "It Always Shows The Current\n Letter You Need To Sign",
    "Green is accurate\n Orange is moderate"
];
receiptInstance = noone;
orderTicketInstance = noone;
pizzaMachineTimerInstance = noone;
