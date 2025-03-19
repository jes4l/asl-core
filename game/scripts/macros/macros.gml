// macros

randomize(); 

// oClient
global.running = false;
global.lastLetter = "";
global.letter = "";
global.letterReceived = "";
global.letterTimeStamp = "";
global.yHand = -1;
global.xHand = -1;

// oGameWordList
global.activeWords = [];

// oDrawDashes
global.dashStartX = 0;
global.dashEndX   = 0;
global.dashY      = 0;

global.wrongLetters       = ds_list_create();
global.wasWrongLetters    = ds_list_create();
global.correctLetters = ds_list_create();
global.confidenceLetters = ds_list_create();

//Car Game
global.lives = 3;
global.score = 0;
global.scoreGained = 0;
global.chosenSprite = -1;
global.gameComplete = false;

global.oRoleGameSprites = undefined;
global.oRoleGameIncorrectSprites = undefined;

function AddPartialSegment(_colorSprite)
{
    if (segmentCount >= 4) {
        show_debug_message("oColourController: All 4 segments already filled!");
        return;
    }
    testTubeSegments[segmentCount] = _colorSprite;
    segmentCount++;

    show_debug_message("oColourController: Segment " + string(segmentCount-1) + " filled with sprite " + string(_colorSprite));
}
global.finalSegments = [ -1, -1, -1, -1 ];
global.finalSegmentCount = 0;

global.obstacleSequence = 0;

global.incorrectWords = ds_list_create();

global.confidence = 0;

global.showWorst = false;