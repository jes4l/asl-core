if (!isMoving && keyboard_check_pressed(vk_space)) {
    if (currentPoint < totalPoints - 1) {
        currentPoint++;
        isMoving = true;
    } else {
        room_goto(rmPizzaGame);
    }
}
if (isMoving && pizzaBase != noone) {
    var moveSpeed = 5;
    var dx = points[currentPoint].x - pizzaBase.x;
    var dy = points[currentPoint].y - pizzaBase.y;
    var distance = point_distance(pizzaBase.x, pizzaBase.y, points[currentPoint].x, points[currentPoint].y);
    if (distance <= moveSpeed) {
        pizzaBase.x = points[currentPoint].x;
        pizzaBase.y = points[currentPoint].y;
        isMoving = false;
    } else {
        pizzaBase.x += (dx / distance) * moveSpeed;
        pizzaBase.y += (dy / distance) * moveSpeed;
    }
}
