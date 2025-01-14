// oShoppingController - Step Event

/// @description Updates sprites based on oLetterOnDashes.wordIndex, 
///              and moves the next word along the path with an offset from the end.

if (!instance_exists(letterController) || !instance_exists(clockObj)) {
    instance_destroy();
    return;
}

// 1) Detect if oLetterOnDashes loaded a new word
var currWordIndex = letterController.wordIndex;
if (currWordIndex != oldWordIndex) {
    // The wordIndex changed => new word was loaded
    // Refresh initialTime from clockObj
    initialTime = clockObj.timeLeft;
    fraction = 0; // restart fraction from 0 for the new next word
    show_debug_message("oShoppingController: Word index changed to "
        + string(currWordIndex) + ", initialTime="
        + string(initialTime) + ", fraction=0");

    oldWordIndex = currWordIndex;
}

// 2) Determine current & next words from global.activeWords
var totalWords = array_length_1d(global.activeWords);

// CURRENT WORD
if (currWordIndex < totalWords) {
    var wordCurrent = global.activeWords[currWordIndex];
    currentSprite   = scrGetWordPoolSprite(wordCurrent, false);
} else {
    currentSprite = -1;
}

// NEXT WORD
if (currWordIndex + 1 < totalWords) {
    var wordNext = global.activeWords[currWordIndex + 1];
    nextSprite   = scrGetWordPoolSprite(wordNext, false);
} else {
    nextSprite = -1;
}

// 3) Move the "next word" along the path based on fraction
//    timeLeft goes from initialTime -> 0 => fraction=1 => near the end, minus offset

var tLeft = clockObj.timeLeft;
if (initialTime <= 0) {
    initialTime = 1; // safety check
}

// fraction = 1 - (timeLeft / initialTime)
fraction = 1 - (tLeft / initialTime);

// clamp fraction
if (fraction < 0) fraction = 0;
if (fraction > 1) fraction = 1;

// 4) Interpolate the next word’s position, but stop short by offsetDist

// If the entire pathDist < offsetDist, reduce offsetDist so we don't overshoot
if (pathDist < offsetDist) {
    offsetDist = pathDist * 0.9;
}

// traveledDist = fraction * (pathDist - offsetDist)
var traveledDist = fraction * (pathDist - offsetDist);
if (traveledDist < 0) traveledDist = 0;

// Normalized direction from start to end
var dirX = dx / pathDist;
var dirY = dy / pathDist;

// Next word's (x,y)
nextWordX = startX + traveledDist * dirX;
nextWordY = startY + traveledDist * dirY;
