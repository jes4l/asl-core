draw_self();
if (instance_exists(letterOnDashesInstance)) {
    var letters = global.currentWordLetters;
    var currentIndex = letterOnDashesInstance.currentIndex;
    if (currentIndex < array_length_1d(letters)) {
        var currentLetter = letters[currentIndex];
        scrDrawText(x, y - 60, "Sign", c_white, 1, fntSevenSegment20);
        scrDrawText(x, y, currentLetter, c_white, 1, fntSevenSegment80);
    }
} else {
    show_debug_message("oLetterOnDashes doesnt exist");
}
