if (timerCurrent > 0) {
    timerCurrent -= 1 / room_speed;
    timerCurrent = max(timerCurrent, 0);
}
