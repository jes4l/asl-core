if (index < letterCount) {
    global.currentSignSprite = sprites[index];
    //show_debug_message("oAutoSigner: Showing letter " + string(index) + " -> " + letters[index]);
    
    index++;
    
    if (index < letterCount) {
        alarm[0] = room_speed * 5;
    } else {
        alarm[0] = room_speed * 5;
    }
} else {

    show_debug_message("oAutoSigner: Signing process done. Transitioning to rmCarGame...");
    room_goto(rmCarGame);
    instance_destroy();
}
