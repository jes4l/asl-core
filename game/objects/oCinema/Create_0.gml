// Determine the width of each lane
var laneWidth = room_width div 3;

// Randomly select a lane: 0, 1, or 2
var selectedLane = irandom(2);

// Calculate the starting x position based on the lane's center
startX = (laneWidth div 2) + (selectedLane * laneWidth);
startY = -sprite_height;

// Set the initial position
x = startX;
y = startY;

// Fixed vertical speed (only affects y-axis)
verticalSpeed = random_range(1.0, 2.5);
