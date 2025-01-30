if (instance_number(oCar) > 1) {
    instance_destroy();
} else {
    x = global.xHand;
    y = global.yHand;

    cameraWidth = 640;
    cameraHeight = 480;
    xScale = room_width / cameraWidth;
    yScale = room_height / cameraHeight;

    carVerticalOffset = 300; 
}
