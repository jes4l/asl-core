// macros - Initialization Script

randomize(); 
global.lastLetter = "";
global.letter = "";
global.hand_x = -1;
global.hand_y = -1;
global.activeWords = [];
global.dashStartX = 0;
global.dashEndX   = 0;
global.dashY      = 0;

global.letterErrorCounts = ds_map_create();

for (var i = 97; i <= 122; i++) { // ASCII codes for 'a' to 'z'
    var letter = string(chr(i));
    ds_map_add(global.letterErrorCounts, letter, 0);
}