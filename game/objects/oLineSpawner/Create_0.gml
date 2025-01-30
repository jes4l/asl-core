numColumns = 5;
columnIndex1 = 2;
columnIndex2 = 3;
thresholdFraction = 0.25;

xPos1 = (room_width / numColumns) * columnIndex1;
xPos2 = (room_width / numColumns) * columnIndex2;
spawnThresholdY = room_height * thresholdFraction;

line1 = noone;
line2 = noone;

lineHeight = sprite_get_height(sLine);

spawnY = -lineHeight;