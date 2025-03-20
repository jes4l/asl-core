textX = 580;
textY = 170;
fontToUse = fntSevenSegment40;
textColor = c_white;
textAlpha = 1;
basket = instance_find(oBasket, 0);
totalPoints = 5;
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
	"Sign My Shopping Items to Aquire Tips\n Your Accuracy Determines Your Tips",
    "The Items In My Basket Will Be Put On\n The Conveyor Belt",
    "You Will Have To Sign The Item\n Before They Reach The Scanner",
    "You Will Not Be Given A ASL Letter\n To Guide You",
    "The Letters You Sign Will Be On\n A Display Like This One",
];
bottomMessages = [
    "Green is accurate\n Orange is moderate",
    "Just Like The One Below",
    "The Itmes Will Travel Via\n Conveyor Belt",
    "The Time The Item Takes To\n Reach The Scanner Is Shown",
    "Hope You Enjoy",
];

tutorialInstance = noone;
