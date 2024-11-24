randomize();
var objects = [oApple, oCarrot, oCheese];
itemQueue = ds_queue_create();
for (var i = 0; i < array_length(objects); i++) {
    ds_queue_enqueue(itemQueue, objects[i]);
}
createInitialObjects();