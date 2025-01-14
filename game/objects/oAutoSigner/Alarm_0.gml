// oAutoSigner - Alarm[0] Event

/// @description Display letters in 5-sec intervals, then wait 5 sec, then go to rmCarGame.

if (index < letterCount) {
    // Display letter at 'index'
    global.currentSignSprite = sprites[index];
    show_debug_message("oAutoSigner: Showing letter " + string(index) + " -> " + letters[index]);
    
    index++;
    
    if (index < letterCount) {
        // Schedule next letter in 5 seconds
        alarm[0] = room_speed * 5;
    } else {
        // We just showed the last letter (20–25 sec).
        // Now set alarm for the final 5-second wait (25–30 sec).
        alarm[0] = room_speed * 5;
        // Next time alarm triggers, index == letterCount
    }
    
} else {
    // If index == letterCount, that means we've already shown all letters.
    // This is the final 5-sec wait done, so 30+ sec => go to rmCarGame.
    show_debug_message("oAutoSigner: Signing process done. Transitioning to rmCarGame...");
    room_goto(rmCarGame);
    instance_destroy(); // optional cleanup
}
