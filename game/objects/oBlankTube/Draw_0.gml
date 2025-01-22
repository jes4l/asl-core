// Example: In oBlankTubeOverlay - Draw Event

// 1) Draw the blank tube
draw_sprite_ext(blankSpr, 0, x, y, 1, 1, 0, c_white, 1);

// 2) Draw each filled segment from bottom to top
var sliceCount   = 4;
var tubeWidth    = 151;
var tubeHeight   = 455;
var sliceHeight  = tubeHeight / sliceCount; // 455 / 4 = 113.75 (float)
var leftX        = x - (tubeWidth  / 2);
var topY         = y - (tubeHeight / 2);

for (var i = 0; i < segmentCount; i++) {
    var colorSpr = testTubeSegments[i];
    if (colorSpr == -1) continue; 

    // We do bottom-up: segment i=0 => bottom chunk => 
    // sourceBottomY = 455 - (i+1)*113.75
    var sourceBottomY = tubeHeight - (i + 1) * sliceHeight; // float

    // Draw that partial slice
    draw_sprite_part_ext(
        colorSpr,         // The color test tube sprite
        0,                // subimage
        0,                // source x (left edge)
        sourceBottomY,    // source y (float OK in GMS2)
        tubeWidth,        // source width
        sliceHeight,      // source height (float)
        leftX,            // destination x
        topY + sourceBottomY, // destination y
        1,                // xscale
        1,                // yscale
        c_white,
        1
    );
}
