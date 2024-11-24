var clock = instance_find(oClock, 0);
if (clock != noone) {
    alarm[0] = room_speed * clock.timerDuration;
} else {
    alarm[0] = room_speed * 10;
}

if (path_position == 0.5) {
    path_position = 1; 
    path_speed = 0;
    alarm[0] = room_speed * clock.timerDuration;
} 
else if (path_position == 1) {
    if (clock != noone) {
        clock.timerCurrent = clock.timerDuration;
    }

    instance_destroy();
    with (oShoppingItemController) {
        createMiddleObject();
    }

    if (clock != noone && instance_number(oItem) == 0 && ds_queue_empty(oShoppingItemController.itemQueue)) {
        clock.timerActive = false;
    }
}