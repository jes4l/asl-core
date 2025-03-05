if (!isMoving && keyboard_check_pressed(vk_space)) {
    if (currentPoint < totalPoints - 1) {
        currentPoint++;
        isMoving = true;
    } else {
        room_goto(rmShoppingGame);
    }
}
if (isMoving && basket != noone) {
    var moveSpeed = 5;
    var dx = points[currentPoint].x - basket.x;
    var dy = points[currentPoint].y - basket.y;
    var distance = point_distance(basket.x, basket.y, points[currentPoint].x, points[currentPoint].y);
    if (distance <= moveSpeed) {
        basket.x = points[currentPoint].x;
        basket.y = points[currentPoint].y;
        isMoving = false;
    } else {
        basket.x += (dx / distance) * moveSpeed;
        basket.y += (dy / distance) * moveSpeed;
    }
}

if (currentPoint == 2 && tutorialInstance == noone) {
    tutorialInstance = instance_create_layer(607, 674, "Instances", oScanTutorial);
    tutorialInstance.image_xscale = 2.624234;
    tutorialInstance.image_yscale = 2.905959;
}

if (currentPoint == 3 && instance_exists(tutorialInstance)) {
    instance_destroy(tutorialInstance);
    tutorialInstance = noone;
}
