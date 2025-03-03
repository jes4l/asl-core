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
