function scrLoadWord(_index)
{
    var theWord = ds_list_find_value(wordsDS, _index);

    // Extract letters, ignoring spaces
    letters = [];
    var rawLen = string_length(theWord);
    for (var i = 1; i <= rawLen; i++)
    {
        var c = string_char_at(theWord, i);
        if (c != " ") {
            array_push(letters, c);
        }
    }
    letterCount = array_length_1d(letters);

    // Initialize letter colors and alphas
    letterColor   = [];
    letterAlpha   = [];
    letterWasWrong= [];
    for (var j = 0; j < letterCount; j++) {
        letterColor[j]   = c_white; 
        letterAlpha[j]   = 0;
        letterWasWrong[j] = false;
    }

    currentIndex = 0;

    var margin    = room_width * 0.05;
    var dashStart = global.dashStartX + margin;
    var dashEnd   = global.dashEndX   - margin;
    var dashY     = global.dashY;
    var dashGap   = room_width * 0.05;

    var totalWidth     = dashEnd - dashStart;
    var totalGaps      = max(0, (letterCount - 1) * dashGap);
    var effectiveWidth = totalWidth - totalGaps;
    var rectWidth      = (letterCount > 0) ? (effectiveWidth / letterCount) : 0;
    var rectHeight     = 40;

    xPositions = [];
    yPositions = [];

    var letterYOffset = 80;

    var cx = dashStart;
    for (var k = 0; k < letterCount; k++) {
        var centerX = cx + (rectWidth * 0.5);
        array_push(xPositions, centerX);
        array_push(yPositions, dashY - letterYOffset);
        cx += rectWidth + dashGap;
    }

    global.currentWordLetters = letters;
    global.currentWordCount   = letterCount;

    if (instance_exists(oClock)) {
        with (oClock) {
            ResetClock();
        }
    }
    
    if (instance_exists(oShoppingController)) {
       with (oShoppingController) {
           fraction = 0;
           initialTime = clockObj.timeLeft; 
       }
    }
}