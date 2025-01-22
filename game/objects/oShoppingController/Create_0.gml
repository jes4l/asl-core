// oShoppingController - Create Event

/// @description Initialize references, path coords, and timing variables

// 1) Find oLetterOnDashes and oClock
letterController = instance_find(oLetterOnDashes, 0);
clockObj         = instance_find(oClock, 0);

// If either doesn't exist, destroy ourselves
if (!instance_exists(letterController) || !instance_exists(clockObj)) {
    show_debug_message("oShoppingController: Missing required objects. Destroying self.");
    instance_destroy();
    return;
}

// 2) Retrieve path start/end from pathShoppingGame (assumes exactly 2 points)
startX = path_get_x(pathShoppingGame, 0);
startY = path_get_y(pathShoppingGame, 0);
endX   = path_get_x(pathShoppingGame, 1);
endY   = path_get_y(pathShoppingGame, 1);

// 3) Initialize
currentSprite = -1;

// Keep track of the old wordIndex to detect changes
oldWordIndex = letterController.wordIndex;

// fraction 0 → sprite at start, fraction 1 → sprite at end
fraction = 0;

// The current word's position
currentWordX = startX;
currentWordY = startY;

// 4) Calculate path distance & direction
dx = endX - startX;
dy = endY - startY;
pathDist = point_distance(startX, startY, endX, endY);

// 5) Read the initial time from oClock once
initialTime = clockObj.timeLeft;

// Optional debug
// show_debug_message("oShoppingController created. Path Start=(" 
//     + string(startX) + "," + string(startY) + ") End=("
//     + string(endX)   + "," + string(endY)   + "). initialTime="
//     + string(initialTime)
// );
