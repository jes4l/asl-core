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
if (currentPoint == 2) {
    if (receiptInstance == noone) {
        receiptInstance = instance_create_layer(605, 490, "Instances", oReciept);
        receiptInstance.image_xscale = 1.077895;
        receiptInstance.image_yscale = 1.206452;
        receiptInstance.depth = 0;
    }
    if (orderTicketInstance == noone) {
        orderTicketInstance = instance_create_layer(603, 687, "Instances", oOrderTicket);
        orderTicketInstance.image_xscale = 0.9496563;
        orderTicketInstance.image_yscale = 0.8800675;
        orderTicketInstance.depth = -1;
    }
} else if (currentPoint >= 3) {
    if (receiptInstance != noone) {
        instance_destroy(receiptInstance);
        receiptInstance = noone;
    }
    if (orderTicketInstance != noone) {
        instance_destroy(orderTicketInstance);
        orderTicketInstance = noone;
    }
}
if (currentPoint == 3) {
    if (pizzaMachineTimerInstance == noone) {
        pizzaMachineTimerInstance = instance_create_layer(1221, 205, "Instances", oPizzaMachineTimer);
        pizzaMachineTimerInstance.image_xscale = 1;
        pizzaMachineTimerInstance.image_yscale = 1;
    }
} else if (currentPoint >= 4) {
    if (pizzaMachineTimerInstance != noone) {
        instance_destroy(pizzaMachineTimerInstance);
        pizzaMachineTimerInstance = noone;
    }
}
