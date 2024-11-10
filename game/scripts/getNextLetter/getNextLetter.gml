/// @function getNextLetter(letterList, targetWord)
/// @param letterList Array of letters typed by the player
/// @param targetWord The word the player is trying to guess
/// @return The next letter to be guessed

function getNextLetter(letterList, targetWord) {
    var currentLength = array_length_1d(letterList);
    var correctIndex = 0;
    var foundIncorrect = false;

    for (var i = 0; i < currentLength; i++) {
        if (letterList[i] != string_char_at(targetWord, i + 1)) {
            correctIndex = i;
            foundIncorrect = true;
            break;
        }
    }

    if (!foundIncorrect) {
        correctIndex = currentLength;
    }

    if (correctIndex < string_length(targetWord)) {
        return string_char_at(targetWord, correctIndex + 1);
    }

    return "";
}
