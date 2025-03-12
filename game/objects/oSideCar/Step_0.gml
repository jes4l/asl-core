if (x < 1476) {
    x += 2;
    if (x > 1476) x = 1476;
} else if (!spawned) {
    instance_create_layer(680,550,"Instances", oSpriteSpawn);
    spawned = true;
	alarm[0] = room_speed *10;
}