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

// 2) Retrieve path start/end from pathShappingGame (assumes exactly 2 points)
startX = path_get_x(pathShoppingGame, 0);
startY = path_get_y(pathShoppingGame, 0);
endX   = path_get_x(pathShoppingGame, 1);
endY   = path_get_y(pathShoppingGame, 1);

// 3) Initialize sprite placeholders to -1 ("no sprite")
currentSprite = -1;
nextSprite    = -1;

// 4) Read initialTime from oClock; store oldWordIndex
initialTime = clockObj.timeLeft; 
oldWordIndex = letterController.wordIndex;

// 5) For the next word’s interpolation
fraction  = 0;
nextWordX = startX;
nextWordY = startY;

// 6) Calculate full path distance for offset logic
dx = endX - startX;
dy = endY - startY;
pathDist = point_distance(startX, startY, endX, endY);

// 7) Offset distance from the end (stop short)
offsetDist = 250;

//show_debug_message("oShoppingController created. Path Start=("
//    + string(startX) + "," + string(startY) + ") End=("
//    + string(endX)   + "," + string(endY)   + "). initialTime="
//    + string(initialTime)
//);
