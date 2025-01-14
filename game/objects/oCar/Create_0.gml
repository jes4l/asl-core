if (instance_number(oCar) > 1) {
    instance_destroy();
} else {
    // Initialize position from global hand coordinates
    x = global.xHand;
    y = global.yHand;

    // Define camera dimensions and scaling
    cameraWidth = 640;
    cameraHeight = 480;
    xScale = room_width / cameraWidth;
    yScale = room_height / cameraHeight;

    // Vertical offset for the car's position
    carVerticalOffset = 300; 
}

