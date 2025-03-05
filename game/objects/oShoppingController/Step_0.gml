if (global.gameComplete) {
    if (!gameCompleteStarted) {
        fraction = room_speed * 4;
        gameCompleteStarted = true;
    }
    if (fraction > room_speed * 2) {
        letterController.statusMessage = "Summing Up";
    } else if (fraction > 0) {
        letterController.statusMessage = "Payed";
    } else {
        room_goto(rmShoppingGameEnd);
    }
    fraction -= 1;
    return;
}

if (!instance_exists(letterController) || !instance_exists(clockObj)) {
    instance_destroy();
    return;
}

var currWordIndex = letterController.wordIndex;
if (currWordIndex != oldWordIndex) {
    initialTime = clockObj.timeLeft;
    if (initialTime <= 0) initialTime = 1;
    fraction = 0;
    currentWordX = startX;
    currentWordY = startY;
    //show_debug_message("oShoppingController: WordIndex changed => " + string(currWordIndex) + ", new initialTime=" + string(initialTime) + ", fraction=0, starting at path beginning");
    oldWordIndex = currWordIndex;
}

var totalWords = array_length_1d(global.activeWords);
if (currWordIndex < totalWords) {
    var wordName = global.activeWords[currWordIndex];
    currentSprite = scrGetWordPoolSprite(wordName, false);
} else {
    currentSprite = -1;
}

if (letterController.nextWordDelay > 0) {
    fraction = 0;
    currentWordX = startX;
    currentWordY = startY;
} else {
    var tLeft = clockObj.timeLeft;
    if (initialTime <= 0) initialTime = 1;
    var effectiveTime = tLeft - 0.5;
    if (effectiveTime < 0) effectiveTime = 0;
    fraction = 1 - (effectiveTime / initialTime);
    if (fraction < 0) fraction = 0;
    if (fraction > 1) fraction = 1;
}

var traveledDist = fraction * pathDist;
var dirX = dx / pathDist;
var dirY = dy / pathDist;
currentWordX = startX + traveledDist * dirX;
currentWordY = startY + traveledDist * dirY;