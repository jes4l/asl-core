// oLineSpawner - Create Event

/// @description Initializes two columns for line spawning.

// 1) Columns at 1/3 and 2/3 of the room width
var sectionWidth = room_width div 3;
xPos1 = sectionWidth;
xPos2 = sectionWidth * 2;

// 2) Store references to the currently active line in each column
line1 = noone;
line2 = noone;

// 3) The threshold to spawn a new line when the bottom of the existing line crosses it
spawnThresholdY = (room_height * 2) / 3; // 2/3 down the room

// 4) The spawn position for new lines: above the top of the room
spawnY = -sprite_get_height(sLine); // e.g. -360 if sLine is 33x360
