// macros - Initialization Script

randomize(); 

// oClient Initialization
global.running = false;
global.lastLetter = "";
global.letter = "";
global.letterReceived = "";
global.letterTimeStamp = "";
global.yHand = -1;
global.xHand = -1;

// oGameWordList Initialization
global.activeWords = [];

// oDrawDashes Initialization
global.dashStartX = 0;
global.dashEndX   = 0;
global.dashY      = 0;

// **New Tracking Variables Initialization**
// Initialize ds_lists for tracking wrong letters, corrected wrong letters, and incomplete letters
global.wrongLetters       = ds_list_create();
global.wasWrongLetters    = ds_list_create();

//Car Game
global.lives = 3;
global.score = 0;
global.scoreGained = 0;
global.chosenSprite = -1;
global.gameComplete = false;

global.oRoleGameSprites = undefined;

function AddPartialSegment(_colorSprite)
{
    if (segmentCount >= 4) {
        show_debug_message("oColourController: All 4 segments already filled!");
        return;
    }

    // Store the correct color in the next available segment
    testTubeSegments[segmentCount] = _colorSprite;
    segmentCount++;

    show_debug_message("oColourController: Segment " + string(segmentCount-1) + " filled with sprite " + string(_colorSprite));
}