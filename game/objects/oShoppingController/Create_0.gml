// 1) Find oLetterOnDashes and oClock
letterController = instance_find(oLetterOnDashes, 0);
clockObj         = instance_find(oClock, 0);

if (!instance_exists(letterController) || !instance_exists(clockObj)) {
    show_debug_message("oShoppingController: Missing required objects. Destroying self.");
    instance_destroy();
    return;
}

// 2) Retrieve path start/end from pathShoppingGame
startX = path_get_x(pathShoppingGame, 0);
startY = path_get_y(pathShoppingGame, 0);
endX   = path_get_x(pathShoppingGame, 1);
endY   = path_get_y(pathShoppingGame, 1);

currentSprite = -1;

// Keep track of the old wordIndex to detect changes
oldWordIndex = letterController.wordIndex;

// fraction 0 → sprite at start, fraction 1 → sprite at end
fraction = 0;

// The current word's position
currentWordX = startX;
currentWordY = startY;

// 3) Calculate path distance & direction
dx = endX - startX;
dy = endY - startY;
pathDist = point_distance(startX, startY, endX, endY);

initialTime = clockObj.timeLeft;

// show_debug_message("oShoppingController created. Path Start=(" 
//     + string(startX) + "," + string(startY) + ") End=("
//     + string(endX)   + "," + string(endY)   + "). initialTime="
//     + string(initialTime)
// );
