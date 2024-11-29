var sectionWidth = room_width div 3;

var selectedLane = irandom(2);

obstacleX = (sectionWidth div 2) + (selectedLane * sectionWidth);

obstacleY = -sprite_height;

obstacleSpeed = 1;

x = obstacleX;
y = obstacleY;
