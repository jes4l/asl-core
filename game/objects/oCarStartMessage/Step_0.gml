if (keyboard_check_pressed(vk_space)) {
    if (currentMessage == 0) {
        timeRemainingText = "Steer by moving your hand left or right\nThe camera is split into three sections for lane changes.";
        leftAlignMessage = false;
        showParkSign = false;
        showObstacleSprite = false;
        currentMessage = 1;
    } else if (currentMessage == 1) {
        timeRemainingText = "Collide With The Correct Road Sign To Turn\n And Reach Your Destination";
        textX = 30;
        textY = 30;
        leftAlignMessage = true;
        showParkSign = true;
        showObstacleSprite = false;
        currentMessage = 2;
    } else if (currentMessage == 2) {
        timeRemainingText = "Watch out for the Obstacles\n Colliding with them loses you a life";
        textX = 30;
        textY = 30;
        leftAlignMessage = true;
        showParkSign = false;
        showObstacleSprite = true;
        currentMessage = 3;
        alarm[2] = room_speed;
    } else if (currentMessage == 3) {
		timeRemainingText = "Now Time To Pick A Passenger Up\n Good Luck";
		textX = room_width / 2;
		textY = 96;
        leftAlignMessage = false;
        showParkSign = false;
        showObstacleSprite = false;
        currentMessage = 4;
	} else if (currentMessage == 4) {
		timeRemainingText = "";
		textX = room_width / 2;
		textY = 96;
        leftAlignMessage = false;
        showParkSign = false;
        showObstacleSprite = false;
		room_goto(rmPlacesGame)
        currentMessage = 5;
	}	
	
}
