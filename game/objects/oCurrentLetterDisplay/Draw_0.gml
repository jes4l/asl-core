draw_self();
if (instance_exists(letterOnDashesInstance)) {
    var letters = global.currentWordLetters;
    var currentIndex = letterOnDashesInstance.currentIndex;
    
    if (currentIndex < array_length_1d(letters)) {
        var currentLetter = letters[currentIndex];
        
        scrDrawText(
            x,
            y,
            currentLetter,
            c_white,
            1,
            fntLetter
        );
    }
} else {
    show_debug_message("oLetterOnDashe doesnt exist");
}
