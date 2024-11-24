function createMiddleObject() {
    if (!ds_queue_empty(itemQueue)) {
        var selectedObject = ds_queue_dequeue(itemQueue);
        var instance = instance_create_layer(path_get_x(ShoppingGamePath, 0.5), path_get_y(ShoppingGamePath, 0.5), "Instances", selectedObject);
        instance.depth = -100;
        instance.path_position = 0.5;
        instance.path_speed = 0;
        instance.alarm[0] = room_speed * 10;
        show_debug_message("New object created in middle: " + string(instance.id));
    }
}