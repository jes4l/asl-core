var sectionWidth = room_width div 5;

var laneCenters = [
    (1 * sectionWidth) + (sectionWidth div 2),
    (2 * sectionWidth) + (sectionWidth div 2),
    (3 * sectionWidth) + (sectionWidth div 2)
];

var laneIndex = irandom_range(0, array_length(laneCenters) - 1);
var spawnX = laneCenters[laneIndex];
var spawnY = -50;
var placeInstance = instance_create_layer(spawnX, spawnY, "Instances", oPlaces);
alarm[0] = room_speed * 10;
