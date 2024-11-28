scaleX = room_width / cameraWidth;
scaleY = room_height / cameraHeight;

x = (cameraWidth - global.hand_x) * scaleX;
y = global.hand_y * scaleY;