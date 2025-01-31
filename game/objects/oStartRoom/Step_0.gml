var timeElapsed = (current_time - startTime) / 1000;
progress = clamp(timeElapsed / 20, 0, 1);
if (progress >= 1) room_goto(rmMenu);

