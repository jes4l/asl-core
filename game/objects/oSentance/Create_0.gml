if (!variable_global_exists("wordList")) {
    global.wordList = [];
}

var wordCount = array_length(global.wordList);

if (wordCount == 1) {
    global.pizzaOrderSentence = "I would like to order a pizza with " + global.wordList[0] + " please.";
} else if (wordCount == 2) {
    global.pizzaOrderSentence = "I would like to order a pizza with " + global.wordList[0] + " and " + global.wordList[1] + " please.";
} else if (wordCount > 2) {
    global.pizzaOrderSentence = "I would like to order a pizza with ";
    for (var i = 0; i < wordCount; i++) {
        if (i == wordCount - 1) {
            global.pizzaOrderSentence += "and " + global.wordList[i];
        } else {
            global.pizzaOrderSentence += global.wordList[i] + ", ";
        }
    }
    global.pizzaOrderSentence += " please.";
} else {
    global.pizzaOrderSentence = "I would like to order a pizza with nothing, please.";
}