if (instance_exists(letterOnDashesInstance)) {
    var letters = global.currentWordLetters;
    var currentIndex = letterOnDashesInstance.currentIndex;
    if (currentIndex < array_length_1d(letters)) {
        var currentLetter = letters[currentIndex];
        currentSignSprite = scrGetASLSprite(currentLetter);
    } else {
        currentSignSprite = -1;
    }
} else {
    currentSignSprite = -1;
}
