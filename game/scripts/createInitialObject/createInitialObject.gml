function createInitialObjects() {
    if (!ds_queue_empty(itemQueue)) {
        var selectedObject = ds_queue_dequeue(itemQueue);
        var instance = instance_create_layer(path_get_x(ShoppingGamePath, 1), path_get_y(ShoppingGamePath, 1), "Instances", selectedObject);
        instance.depth = -100;
        instance.path_position = 1;
        instance.path_speed = 0;

        // Sync with clock timing
        var clock = instance_find(oClock, 0);
        if (clock != noone) {
            instance.alarm[0] = room_speed * clock.timerDuration;
        }
    }
    if (!ds_queue_empty(itemQueue)) {
        var selectedObject = ds_queue_dequeue(itemQueue);
        var instance = instance_create_layer(path_get_x(ShoppingGamePath, 0.5), path_get_y(ShoppingGamePath, 0.5), "Instances", selectedObject);
        instance.depth = -100;
        instance.path_position = 0.5;
        instance.path_speed = 0;

        // Sync with clock timing
        var clock = instance_find(oClock, 0);
        if (clock != noone) {
            instance.alarm[0] = room_speed * clock.timerDuration;
        }
    }
}
