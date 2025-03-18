


if (keyboard_check_pressed(vk_space)) {
	global.activeWords = [];
	global.lives = 3;
	global.dashStartX = 0;
	global.dashEndX   = 0;
	global.dashY      = 0;
	global.currentSignSprite = "";
	global.scoreGained = 0;
	global.obstacleSequence = 0;
	room_goto(rmMenu);
}