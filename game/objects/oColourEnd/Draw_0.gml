draw_sprite_ext(blankSpr, 0, x, y, 1, 1, 0, c_white, 1);
var ox = sprite_get_xoffset(blankSpr);
var oy = sprite_get_yoffset(blankSpr);
var leftX = x - ox;
var topY = y - oy;
var sliceCount = 4;
var tubeWidth = 121;
var tubeHeight = 364;
var sliceHeight = tubeHeight / sliceCount;
for (var i = 0; i < segmentCount; i++) {
    var colorSpr = testTubeSegments[i];
    if (colorSpr == -1) continue;
    var sourceBottomY = tubeHeight - (i + 1) * sliceHeight;
    draw_sprite_part_ext(
        colorSpr,
        0,
        0,
        sourceBottomY,
        tubeWidth,
        sliceHeight,
        leftX,
        topY + sourceBottomY,
        1,
        1,
        c_white,
        1
    );
}