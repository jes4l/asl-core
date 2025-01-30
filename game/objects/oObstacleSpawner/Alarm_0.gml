var sectionWidth = room_width div 5;

var laneCenters = [
    (1 * sectionWidth) + (sectionWidth div 2),
    (2 * sectionWidth) + (sectionWidth div 2),
    (3 * sectionWidth) + (sectionWidth div 2)
];

var randomLaneIndex = irandom_range(0, array_length(laneCenters) - 1);
var spawnX = laneCenters[randomLaneIndex];
var spawnY = -50;
var obstacle = instance_create_layer(spawnX, spawnY, "Instances", oObstacle);
alarm[0] = room_speed * 7;
