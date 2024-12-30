// oCurrentSignDisplay - Step Event

// Ensure that the oLetterOnDashes instance exists
if (instance_exists(letterOnDashesInstance)) {
    // Access the global array of letters for the current word
    var letters = global.currentWordLetters;

    // Access the current index from oLetterOnDashes to determine the next letter to sign
    var currentIndex = letterOnDashesInstance.currentIndex;

    // Check if the current index is within the bounds of the letters array
    if (currentIndex < array_length_1d(letters)) {
        // Retrieve the current letter
        var currentLetter = letters[currentIndex];

        // Get the ASL sprite using the scrGetASLSprite function
        currentSignSprite = scrGetASLSprite(currentLetter);
    } else {
        // Optionally, handle the case where there are no more letters
        currentSignSprite = -1; // Indicate no sprite to display
    }
} else {
    // If oLetterOnDashes doesn't exist, indicate no sprite to display
    currentSignSprite = -1;
}
