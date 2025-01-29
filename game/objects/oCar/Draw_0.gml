// oCar - Draw Event

// 1. Draw dividing lines
var sectionWidth = room_width div 3;
var lineThickness = 5;

//for (var i = 1; i <= 2; i++) {
//    var xLine = sectionWidth * i;
//    draw_set_color(c_white);
//    draw_rectangle(
//        xLine - (lineThickness div 2), 
//        0, 
//        xLine + (lineThickness div 2), 
//        room_height, 
//        false
//    );
//}

// 2. Draw the car
draw_sprite_ext(sCar, 0, x, y, 1, 1, 0, c_white, 1);

// 3. Display Lives further to the right
var livesString = "Lives: " + string(global.lives);

// Because scrDrawText centers the text at (x, y), you can move the coordinates
// to something like (100, 40) so it appears more visually left-aligned near the corner.
scrDrawText(150, 100, livesString, c_white, 1, fntWord);
