// oShoppingController - Step Event

/// @description Moves the current word from start→end, finishing 1 second earlier than normal.

if (!instance_exists(letterController) || !instance_exists(clockObj)) {
    instance_destroy();
    return;
}

// 1) Check if oLetterOnDashes loaded a new word
var currWordIndex = letterController.wordIndex;
if (currWordIndex != oldWordIndex) {
    // A new word => reset fraction=0, re-grab initialTime
    initialTime = clockObj.timeLeft;
    fraction    = 0;

    show_debug_message("oShoppingController: WordIndex changed => " 
        + string(currWordIndex) + ", new initialTime=" + string(initialTime) 
        + ", fraction=0");
    oldWordIndex = currWordIndex;
}

// 2) Determine the current word’s sprite (if valid index)
var totalWords = array_length_1d(global.activeWords);
if (currWordIndex < totalWords) {
    var wordName    = global.activeWords[currWordIndex];
    currentSprite   = scrGetWordPoolSprite(wordName, false);
} else {
    currentSprite   = -1;
}

// 3) fraction calculation with a 1-second offset
var tLeft = clockObj.timeLeft;
if (initialTime <= 0) {
    initialTime = 1; // safety
}

// Subtract 1 second from the time left to finish early
var effectiveTime = tLeft - 1;
// clamp effectiveTime so it can’t go below 0
if (effectiveTime < 0) {
    effectiveTime = 0;
}

// fraction = 1 - (effectiveTime / initialTime)
fraction = 1 - (effectiveTime / initialTime);

// clamp fraction to [0..1]
if (fraction < 0) fraction = 0;
if (fraction > 1) fraction = 1;

// 4) Interpolate the current word’s position
var traveledDist = fraction * pathDist;
var dirX = dx / pathDist;
var dirY = dy / pathDist;

currentWordX = startX + traveledDist * dirX;
currentWordY = startY + traveledDist * dirY;

// Optional: If fraction == 1, the word is fully at the end
// you could do logic like:
// if (fraction >= 1) {
//     show_debug_message("Reached the end 1 second early!");
// }
