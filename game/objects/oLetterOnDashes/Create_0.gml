// oLetterOnDashes - Create Event

// Set depth to draw on top of other objects
depth = -10;

// Reference to the words list
var listObj = instance_find(oGameWordList, 0);
if (!instance_exists(listObj)) {
    show_debug_message("No game word list found. Destroying oLetterOnDashes.");
    instance_destroy();
    return;
}

wordsDS = listObj.wordsList;
wordsTotal = ds_list_size(wordsDS);
if (wordsTotal <= 0) {
    show_debug_message("No words in the list!");
    instance_destroy();
    return;
}

// Tracking variables
wordIndex = 0;         
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

// Status message
statusMessage = "";
statusTimer = 0;

// Helper function to load a word
function LoadWord(_index) {
    var theWord = ds_list_find_value(wordsDS, _index);

    // Extract letters, ignoring spaces
    letters = [];
    var rawLen = string_length(theWord);
    for (var i = 1; i <= rawLen; i++) {
        var c = string_char_at(theWord, i);
        if (c != " ") {
            array_push(letters, c);
        }
    }
    letterCount = array_length_1d(letters);

    // Initialize colors and alphas
    letterColor = [];
    letterAlpha = [];
    for (var i = 0; i < letterCount; i++) {
        letterColor[i] = c_white; 
        letterAlpha[i] = 0;       
    }

    // Reset current index
    currentIndex = 0;

    // Dash positioning parameters
    var margin = 50;
    var dashStart = global.dashStartX + margin;
    var dashEnd   = global.dashEndX   - margin;
    var dashY     = global.dashY;
    var dashGap   = 50;

    var totalWidth     = dashEnd - dashStart;
    var totalGaps      = max(0, (letterCount - 1) * dashGap);
    var effectiveWidth = totalWidth - totalGaps;
    var rectWidth      = (letterCount > 0) ? (effectiveWidth / letterCount) : 0;
    var rectHeight     = 40;

    // Calculate positions for each letter's dash
    xPositions = [];
    yPositions = [];

    // Define the vertical offset (in pixels)
    var letterYOffset = 80;

    var cx = dashStart;
    for (var i = 0; i < letterCount; i++) {
        var centerX = cx + (rectWidth * 0.5);
        array_push(xPositions, centerX);
        
        // Apply the vertical offset to move the letter upward
        array_push(yPositions, dashY - letterYOffset);
        
        cx += rectWidth + dashGap;
    }

    // Auto-fill logic: Compare last letter of previous word with first letter of current word
    if (_index > 0 && letterCount > 0) {
        var prevWord = ds_list_find_value(wordsDS, _index - 1);
        var lastLetterPrev = "";
        var pLen = string_length(prevWord);
        for (var j = pLen; j >= 1; j--) {
            var ch = string_char_at(prevWord, j);
            if (ch != " ") {
                lastLetterPrev = ch;
                break;
            }
        }

        var firstLetterNext = letters[0];

        if (lastLetterPrev != "" && firstLetterNext == lastLetterPrev) {
            var k = 1;
            while (k < letterCount && letters[k] == firstLetterNext) {
                k++;
            }
            for (var i = 0; i < k; i++) {
                letterColor[i] = c_green;
                letterAlpha[i] = 1.0;
            }
            currentIndex = k;
        }
    }

    // Set global variables for current word
    global.currentWordLetters = letters;
    global.currentWordCount = letterCount;
}

// Load the first word
LoadWord(wordIndex);
drawOLetterOnDashes = false;
