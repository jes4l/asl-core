if (index < letterCount) {
    global.currentSignSprite = sprites[index];
    show_debug_message("oAutoSigner: Showing letter " + string(index) + " -> '" + letters[index] + "'");
    
    index++;

    if (index < letterCount) {
        alarm[0] = room_speed * 4;
    } else {
        alarm[0] = room_speed * 4;
    }
} else {
    show_debug_message("oAutoSigner: Signing process done.");
    // instance_destroy();
}
