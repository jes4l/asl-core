perf = scrCalculatePerformance();

fadeTimer = 0;
currentLetter = 0;
fadeSpeed = 0.02;
lettersToDisplay = perf.best;
alphaArray = array_create(array_length(lettersToDisplay), 0);


show_debug_message("Best Letters:");
for (var i = 0; i < array_length_1d(perf.best); i++) {
    var letterInfo = perf.best[i];
    show_debug_message(letterInfo.letter + " - " + string(letterInfo.weight));
}

show_debug_message("Worst Letters:");
for (var i = 0; i < array_length_1d(perf.worst); i++) {
    var letterInfo = perf.worst[i];
    show_debug_message(letterInfo.letter + " - " + string(letterInfo.weight));
}
