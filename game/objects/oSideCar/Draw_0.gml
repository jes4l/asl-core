draw_self();
var txtColor;
if (room == rmPlacesGameCinema || room == rmPlacesGameHospital) {
    txtColor = c_white;
} else {
    txtColor = c_black;
}
if (x < 1476) {
    scrDrawText(room_width/2, 1020, "I have arrived at the " + global.activeWords[0], txtColor, 1, fntSevenSegment80);
} else {
    scrDrawText(room_width/2, 1020, "You Got A Tip Of " + string(global.scoreGained) + ". This Is Your Overall Tip " + string(global.score), txtColor, 1, fntSevenSegment60);
}