var perf = scrCalculatePerformance();

showWorst = false;

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
