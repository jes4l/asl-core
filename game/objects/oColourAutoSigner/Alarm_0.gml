// oAutoSigner - Alarm[0] Event

/// @description Displays each subsequent letter every 5 seconds.

if (index < letterCount) {
    // Display letter at 'index'
    global.currentSignSprite = sprites[index];
    show_debug_message("oAutoSigner: Showing letter " + string(index) + " -> '" + letters[index] + "'");
    
    index++;

    if (index < letterCount) {
        // Schedule next letter in 5 seconds
        alarm[0] = room_speed * 5;
    } else {
        // Showed the last letter. Wait another 5 seconds if needed
        alarm[0] = room_speed * 5;
    }
} else {
    // If index == letterCount, all letters are shown
    show_debug_message("oAutoSigner: Signing process done.");
    // Optionally transition or destroy this instance:
    // instance_destroy();
}
