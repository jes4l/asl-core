// oPlacesSpawner - Alarm[0] Event

/// @description Spawns an oPlaces object in one of three lanes, then resets alarm

// 1) Determine lane centers
var sectionWidth = room_width div 3;
var laneCenters = [
    sectionWidth div 2,                   // Lane 1 center
    sectionWidth + (sectionWidth div 2),  // Lane 2 center
    room_width - (sectionWidth div 2)     // Lane 3 center
];

// 2) Pick a random lane
var laneIndex = irandom_range(0, array_length_1d(laneCenters) - 1);
var spawnX = laneCenters[laneIndex];

// 3) Spawn near the top (like an obstacle). If you want it lower, adjust.
var spawnY = -50;

// 4) Create an instance of oPlaces
var placeInstance = instance_create_layer(spawnX, spawnY, "Instances", oPlaces);

// 5) Reset alarm for next spawn
alarm[0] = room_speed * 10;
