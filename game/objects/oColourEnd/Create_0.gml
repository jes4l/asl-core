x = room_width/2;
y = 550;
blankSpr = sBlankTestTube;
if (variable_global_exists("finalSegments")) {
    testTubeSegments = global.finalSegments;
    segmentCount = global.finalSegmentCount;
} else {
    testTubeSegments = [ -1, -1, -1, -1 ];
    segmentCount = 0;
    show_debug_message("oColourEnd: global.finalSegments not initialized, using default empty tube");
}