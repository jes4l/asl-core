if (!instance_exists(letterController) || !instance_exists(clockObj)) {
    instance_destroy();
    return;
}

// 1) Check if oLetterOnDashes loaded a new word
var currWordIndex = letterController.wordIndex;
if (currWordIndex != oldWordIndex) {
    initialTime = clockObj.timeLeft;
    if (initialTime <= 0) initialTime = 1;
    fraction    = 0;
    currentWordX = startX;
    currentWordY = startY;
    
    show_debug_message("oShoppingController: WordIndex changed => " 
        + string(currWordIndex) + ", new initialTime=" + string(initialTime) 
        + ", fraction=0, starting at path beginning");
    oldWordIndex = currWordIndex;
}


var totalWords = array_length_1d(global.activeWords);
if (currWordIndex < totalWords) {
    var wordName    = global.activeWords[currWordIndex];
    currentSprite   = scrGetWordPoolSprite(wordName, false);
} else {
    currentSprite   = -1;
}

// 2) Calculate fraction
// If the next word delay is active, force fraction to 0 and position at the start.
if (letterController.nextWordDelay > 0) {
    fraction = 0;
    currentWordX = startX;
    currentWordY = startY;
} else {
    var tLeft = clockObj.timeLeft;
    
    if (initialTime <= 0) {
        initialTime = 1;
    }
    
    // Subtract 0.5 seconds from the time left to finish early.
    var effectiveTime = tLeft - 0.5;
    if (effectiveTime < 0) {
        effectiveTime = 0;
    }
    
    // Calculate fraction from effective time.
    fraction = 1 - (effectiveTime / initialTime);
    
    // Clamp fraction to [0, 1].
    if (fraction < 0) fraction = 0;
    if (fraction > 1) fraction = 1;
}

var traveledDist = fraction * pathDist;
var dirX = dx / pathDist;
var dirY = dy / pathDist;

currentWordX = startX + traveledDist * dirX;
currentWordY = startY + traveledDist * dirY;
