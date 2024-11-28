scaleX = room_width / cameraWidth;
scaleY = room_height / cameraHeight;

var linear_x = (cameraWidth - global.hand_x) * scaleX;

var section_width = room_width div 3;
if(linear_x < section_width) {
    x = section_width div 2;
} else if (linear_x < section_width * 2) {
    x = section_width + (section_width div 2); 
} else {
    x = room_width - (section_width div 2); 
}

y = room_height - 50;


