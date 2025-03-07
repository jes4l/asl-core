x = 1665;
y = 500;

blankSpr = sBlankTestTube;

testTubeSegments = [ -1, -1, -1, -1 ];
segmentCount     = 0;

function AddPartialSegment(_colorSprite)
{
    if (segmentCount >= 4) {
        show_debug_message("oBlankTubeOverlay: All 4 segments already filled!");
        return;
    }

    testTubeSegments[segmentCount] = _colorSprite;
    segmentCount++;

    show_debug_message("oBlankTubeOverlay: segment " 
        + string(segmentCount - 1) + " filled with " + string(_colorSprite));
}
