if (ds_list_size(bagList) < numBagsToSpawn) {
    spawnTimer -= 1;
    if (spawnTimer <= 0) {
        var bag = instance_create_layer(bagStartX, bagStartY, "Instances", oShoppingBag);
        var bag2 = instance_create_layer(bagStartX, bagStartY, "Instances", oShoppingBag2);
        bag.progress = 0;
        bag.activeWord = global.correctWords[ds_list_size(bagList)];
        bag2.progress = 0;
        bag2.activeWord = global.correctWords[ds_list_size(bag2List)];
        ds_list_add(bagList, bag);
        ds_list_add(bag2List, bag2);
        spawnTimer = spawnDelay;
    }
}
if (!allBagsStopped) {
    var bagCount = ds_list_size(bagList);
    for (var i = 0; i < bagCount; i++) {
        var bag = bagList[| i];
        var bag2 = bag2List[| i];
        if (bag != noone && bag.progress < 1) {
            bag.progress = min(bag.progress + bagSpeed, 1);
            bag.x = lerp(bagStartX, bagEndX, bag.progress);
            bag.y = bagStartY;
            bag2.progress = bag.progress;
            bag2.x = bag.x;
            bag2.y = bag.y;
            if (bag.progress == 1) {
                allBagsStopped = true;
                break;
            }
        }
    }
}
