/*
var sectionWidth = room_width div 5;
var lineThickness = 5;
for (var i = 1; i <= 4; i++) {
    var xLine = sectionWidth * i;
    draw_set_color(c_white);
    draw_rectangle(
        xLine - (lineThickness div 2), 
        0, 
        xLine + (lineThickness div 2), 
        room_height, 
        false
    );
}
*/


draw_sprite_ext(sCar, 0, x, y, 1, 1, 0, c_white, 1);

var livesString = "Lives: " + string(global.lives);

scrDrawText(150, 100, livesString, c_white, 1, fntWord);
