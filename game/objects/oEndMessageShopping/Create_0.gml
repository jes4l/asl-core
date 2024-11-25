// oShoppingController Create Event
if (!variable_global_exists("wordToObjectMap")) {
    global.wordToObjectMap = ds_map_create();
    ds_map_add(global.wordToObjectMap, "bac", oApple);
    ds_map_add(global.wordToObjectMap, "cab", oCarrot);
    ds_map_add(global.wordToObjectMap, "abc", oCheese);
}


if (!variable_global_exists("wordList")) {
    global.wordList = [];
}

if (!variable_global_exists("customEndMessage")) {
    global.customEndMessage = "Scan Shopping Before Timer Runs Out";
}

global.pizzaOrderEnd = global.customEndMessage;
