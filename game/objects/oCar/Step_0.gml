// oCar - Step Event

// 1. Calculate scaled x position
var xLinear = (cameraWidth - global.xHand) * xScale;

// 2. Three-lane logic
var sectionWidth = room_width div 3;

if (xLinear < sectionWidth) {
    x = sectionWidth div 2;
} else if (xLinear < sectionWidth * 2) {
    x = sectionWidth + (sectionWidth div 2);
} else {
    x = room_width - (sectionWidth div 2);
}

// 3. Fix vertical position
y = room_height - carVerticalOffset;

// 4. Check lives
if (global.lives <= 0) {
    show_debug_message("oCar: Lives are 0. Returning to rmMenu...");
    room_goto(rmMenu);
}
