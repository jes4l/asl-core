// Determine the width of each lane
var sectionWidth = room_width div 3;

// Randomly select a lane: 0, 1, or 2
var selectedLane = irandom(2);

// Set the initial x position based on the lane center
obstacleX = (sectionWidth div 2) + (selectedLane * sectionWidth);

// Start at the top of the screen
obstacleY = -sprite_height;

// Fixed vertical speed
obstacleSpeed = 1;

// Set the obstacle's position
x = obstacleX;
y = obstacleY;
