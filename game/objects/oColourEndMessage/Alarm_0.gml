if (global.scoreGained == 6) {
    timeRemainingText = "All the test tubes are correct\n You Got A Tip Of " + string(global.scoreGained) + "\n This Is Your Overall Tip " + string(global.score);
} else if (global.scoreGained == 4 || global.scoreGained == 5) {
    timeRemainingText = "Some Test Tubes were incorrect\n You Got A Tip Of " + string(global.scoreGained) + "\n This Is Your Overall Tip " + string(global.score);
} else {
    timeRemainingText = "Most test tubes were incorrect\n You Got A Tip Of " + string(global.scoreGained) + "\n This Is Your Overall Tip " + string(global.score);
}
alarm[1] = room_speed * 5;
