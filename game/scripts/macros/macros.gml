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
global.incompleteLetters  = ds_list_create();
