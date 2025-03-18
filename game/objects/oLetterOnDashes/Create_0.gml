depth = -10;
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
wordIndex = 0;
wordsCompleted = 0;
letters = [];
letterCount = 0;
xPositions = [];
yPositions = [];
letterColor = [];
letterAlpha = [];
currentIndex = 0;
wrongLetter = "";
wrongLetterAlpha = 0;
wrongLetterX = 0;
wrongLetterY = 0;
letterWasWrong = [];
incompleteLetters = [];
statusMessage = "";
statusTimer = 0;
nextWordDelay = 0;
scrLoadWord(wordIndex);
drawOLetterOnDashes = true;
