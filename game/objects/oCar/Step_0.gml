var xLinear = (cameraWidth - global.xHand) * xScale;
var sectionWidth = room_width div 5;

if (xLinear < (sectionWidth * 2)) {
    x = (1 * sectionWidth) + (sectionWidth div 2);
}
else if (xLinear < (sectionWidth * 3)) {
    x = (2 * sectionWidth) + (sectionWidth div 2);
}
else {
    x = (3 * sectionWidth) + (sectionWidth div 2);
}

y = room_height - carVerticalOffset;
if (global.lives <= 0) {
	global.activeWords = [];
	global.lives = 3;
	global.dashStartX = 0;
	global.dashEndX   = 0;
	global.dashY      = 0;
	global.currentSignSprite = "";
    room_goto(rmMenu);
}
