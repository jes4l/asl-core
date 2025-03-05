letterController = instance_find(oLetterOnDashes, 0);
clockObj = instance_find(oClock, 0);
if (!instance_exists(letterController) || !instance_exists(clockObj)) {
    instance_destroy();
    return;
}
startX = path_get_x(pathShoppingGame, 0);
startY = path_get_y(pathShoppingGame, 0);
endX = path_get_x(pathShoppingGame, 1);
endY = path_get_y(pathShoppingGame, 1);
currentSprite = -1;
oldWordIndex = letterController.wordIndex;
fraction = 0;
currentWordX = startX;
currentWordY = startY;
dx = endX - startX;
dy = endY - startY;
pathDist = point_distance(startX, startY, endX, endY);
initialTime = clockObj.timeLeft;
gameCompleteStarted = false;

// show_debug_message("oShoppingController created. Path Start=(" 
//     + string(startX) + "," + string(startY) + ") End=("
//     + string(endX)   + "," + string(endY)   + "). initialTime="
//     + string(initialTime)
// );
