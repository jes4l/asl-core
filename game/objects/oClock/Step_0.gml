/// oClock - Step Event

// timeLeft should smoothly decrease at a rate of 1 second per room_speed steps
// i.e., 1 second per 60 frames if room_speed=60
if (timeLeft > 0) {
    timeLeft -= 1 / room_speed; 
    // This means each frame we subtract 1/60 if room_speed=60,
    // so in 1 second, timeLeft drops by exactly 1.
}

if (timeLeft < 0) {
    timeLeft = 0;
}
