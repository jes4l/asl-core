if (!variable_global_exists("wordList")) {
    global.wordList = [];
}

var wordCount = array_length(global.wordList);

if (wordCount == 1) {
    global.pizzaOrderEnd = "Thank you for the " + global.wordList[0] + " pizza. Have a great day!";
} else if (wordCount == 2) {
    global.pizzaOrderEnd = "Thank you for the " + global.wordList[0] + " and " + global.wordList[1] + " pizza. Have a great day!";
} else if (wordCount > 2) {
    global.pizzaOrderEnd = "Thank you for the ";
    for (var i = 0; i < wordCount; i++) {
        if (i == wordCount - 1) {
            global.pizzaOrderEnd += "and " + global.wordList[i];
        } else {
            global.pizzaOrderEnd += global.wordList[i] + ", ";
        }
    }
    global.pizzaOrderEnd += " pizza. Have a great day!";
} else {
    global.pizzaOrderEnd = "Thank you for the pizza. Have a great day!";
}