/// oClock - Alarm[0] Event

timeLeft--;

if (timeLeft < 0) {
    timeLeft = 0;
}

// If there’s still time left, set the alarm again
if (timeLeft > 0) {
    alarm[0] = room_speed;
}
