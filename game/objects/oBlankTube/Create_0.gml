// oBlankTubeOverlay - Create Event

/// @description Sets up a blank test tube overlay system at (1600, 350).

// 1) Position for the blank test tube
x = 1665;
y = 500;

// 2) Blank test tube sprite (assumed 512×512)
blankSpr = sBlankTestTube;

// 3) We'll store up to 4 partial color segments in an array
testTubeSegments = [ -1, -1, -1, -1 ]; // Each entry is the sprite for the correct color or -1
segmentCount     = 0; // how many segments are filled (0..4)

// 4) Provide a function to add a partial segment from a correct color sprite
function AddPartialSegment(_colorSprite)
{
    // If we've already filled 4 segments, do nothing
    if (segmentCount >= 4) {
        show_debug_message("oBlankTubeOverlay: All 4 segments already filled!");
        return;
    }

    testTubeSegments[segmentCount] = _colorSprite;
    segmentCount++;

    show_debug_message("oBlankTubeOverlay: segment " 
        + string(segmentCount - 1) + " filled with " + string(_colorSprite));
}
