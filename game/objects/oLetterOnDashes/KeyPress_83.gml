
if (currentIndex < letterCount) {
    var skippedLetter = letters[currentIndex];

    ds_list_add(global.correctLetters, string_upper(skippedLetter));

    letterColor[currentIndex] = c_green;
    letterAlpha[currentIndex] = 1.0;

    var pair = [string_upper(skippedLetter), 0];
    ds_list_add(global.confidenceLetters, pair);
    global.currentWordConfidence[currentIndex] = 0;

    currentIndex++;
}
