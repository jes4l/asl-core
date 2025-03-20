var t = (current_time - startTime) / 1000;
if (t < 14) {
    progress = (t / 14) * 0.25;
} else if (t < 24) {
    progress = 0.25;
} else if (t < 24.001) {
    progress = 0.30;
} else if (t < 38) {
    progress = 0.30 + ((t - 24) / 14) * (0.75 - 0.30);
} else if (t < 60) {
    progress = 0.75;
} else {
    room_goto(rmMenu);
}
if (global.connectionStatus == "Connected") {
    room_goto(rmMenu);
}