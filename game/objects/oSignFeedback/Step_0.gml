if (global.letter != "") {
    if (overlayLetter != string_upper(global.letter)) {
        overlayLetter = string_upper(global.letter);
        fadeAlpha = 1;
    }
}

if (overlayLetter != "") {
    var expectedLetter = global.currentWordLetters[0];
    if (overlayLetter != expectedLetter) {
        fadeAlpha = max(0, fadeAlpha - 0.05);
    }
}

if (overlayLetter != "") {
    var expectedLetter = global.currentWordLetters[0];
    if (overlayLetter == expectedLetter) {
        global.currentWordConfidence[0] = global.confidence;
    } else {
        global.currentWordConfidence[0] = -1;
    }
}
if (keyboard_check_pressed(vk_space)) {
    room_goto(rmFeedback);
}
