// oObstacleSpawner - Alarm[0] Event

/// @description Spawns an obstacle in one of three lanes, then resets the alarm

// 1) Determine lane centers
var sectionWidth = room_width div 3;
var laneCenters = [
    sectionWidth div 2,                   // Lane 1 center
    sectionWidth + (sectionWidth div 2),  // Lane 2 center
    room_width - (sectionWidth div 2)     // Lane 3 center
];

// 2) Pick a random lane
var randomLaneIndex = irandom_range(0, array_length_1d(laneCenters) - 1);
var spawnX = laneCenters[randomLaneIndex];

// 3) Y-position for spawning (top of the room)
var spawnY = -50; // Slightly above visible area so it drops in, if you wish

// 4) Create the obstacle instance
//    We assume you'll have a dedicated object named oObstacle or something similar.
//    If you just have a sprite (sObstacle), create a small object that uses that sprite.
var obstacle = instance_create_layer(spawnX, spawnY, "Instances", oObstacle);

// Optional: Set the obstacle’s sprite if not set in oObstacle
// obstacle.sprite_index = sObstacle;

// 5) Reset alarm for the next spawn
alarm[0] = room_speed * 7;
