/// oLetterOnDashes - Create Event

// Set depth to draw on top of other objects
depth = -10;

// Reference to the words list
var listObj = instance_find(oGameWordList, 0);
if (!instance_exists(listObj)) {
    show_debug_message("No game word list found. Destroying oLetterOnDashes.");
    instance_destroy();
    return;
}

wordsDS    = listObj.wordsList;
wordsTotal = ds_list_size(wordsDS);
if (wordsTotal <= 0) {
    show_debug_message("No words in the list!");
    instance_destroy();
    return;
}

// Tracking variables
wordIndex      = 0;         
wordsCompleted = 0;    

// Current word data
letters      = [];     
letterCount  = 0;
xPositions   = [];
yPositions   = [];
letterColor  = [];
letterAlpha  = [];
currentIndex = 0;      

// Wrong guesses
wrongLetter      = "";
wrongLetterAlpha = 0;
wrongLetterX     = 0;
wrongLetterY     = 0;
letterWasWrong = [];

// Status message
statusMessage = "";
statusTimer   = 0;

// Helper function to load a word
function LoadWord(_index)
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
    letterColor = [];
    letterAlpha = [];
	letterWasWrong  = [];
    for (var j = 0; j < letterCount; j++) {
        letterColor[j] = c_white; 
        letterAlpha[j] = 0;
		letterWasWrong[i] = false;
    }

    // Reset current index
    currentIndex = 0;

    // Dash positioning parameters
    var margin    = 50;
    var dashStart = global.dashStartX + margin;
    var dashEnd   = global.dashEndX   - margin;
    var dashY     = global.dashY;
    var dashGap   = 50;

    var totalWidth     = dashEnd - dashStart;
    var totalGaps      = max(0, (letterCount - 1) * dashGap);
    var effectiveWidth = totalWidth - totalGaps;
    var rectWidth      = (letterCount > 0) ? (effectiveWidth / letterCount) : 0;
    var rectHeight     = 40;

    xPositions = [];
    yPositions = [];

    // Define the vertical offset (in pixels)
    var letterYOffset = 80;

    var cx = dashStart;
    for (var k = 0; k < letterCount; k++) {
        var centerX = cx + (rectWidth * 0.5);
        array_push(xPositions, centerX);
        array_push(yPositions, dashY - letterYOffset);
        cx += rectWidth + dashGap;
    }

    // Auto-fill logic (compare last letter of the previous word with first letter of current word)
    if (_index > 0 && letterCount > 0) {
        var prevWord       = ds_list_find_value(wordsDS, _index - 1);
        var lastLetterPrev = "";
        var pLen           = string_length(prevWord);

        for (var m = pLen; m >= 1; m--) {
            var ch = string_char_at(prevWord, m);
            if (ch != " ") {
                lastLetterPrev = ch;
                break;
            }
        }

        var firstLetterNext = letters[0];

        if (lastLetterPrev != "" && firstLetterNext == lastLetterPrev) {
            var n = 1;
            while (n < letterCount && letters[n] == firstLetterNext) {
                n++;
            }
            for (var ii = 0; ii < n; ii++) {
                letterColor[ii] = c_green;
                letterAlpha[ii] = 1.0;
            }
            currentIndex = n;
        }
    }

    // Update global variables for the current word
    global.currentWordLetters = letters;
    global.currentWordCount   = letterCount;

    // Tell oClock to refresh its timer using THIS word's length
    if instance_exists(oClock) {
        with (oClock) {
            ResetClock();
        }
    }
}

// Load the first word
LoadWord(wordIndex);
drawOLetterOnDashes = false;
