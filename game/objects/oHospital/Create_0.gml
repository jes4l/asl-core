var laneWidth = room_width div 3;

var selectedLane = irandom(2);

startX = (laneWidth div 2) + (selectedLane * laneWidth);
startY = -sprite_height;

x = startX;
y = startY;

verticalSpeed = random_range(1.0, 2.5);
