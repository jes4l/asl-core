if (displayStage < 2) {
    timer += 1;
    if (timer >= room_speed * 2) {
        displayStage++;
        timer = 0;
    }
} else if (displayStage == 2 && !gameEnd) {
    alarm[0] = room_speed * 2;
    gameEnd = true;
}
