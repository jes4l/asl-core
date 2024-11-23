/// @function updateWordList(gameName)
/// @param gameName The name of the current game
function updateWordList(gameName) {
    if (ds_map_exists(global.gameWordLists, gameName)) {
        global.wordList = global.gameWordLists[? gameName];
    } else {
        show_debug_message("Error: Game name not found in word lists map.");
    }
}