// oColourController - Step Event

/// @description Checks for clicks on the 4 sprites, handles feedback timer

// 1) If we're showing feedback (correct/incorrect), decrement feedbackTimer
if (feedbackTimer > 0) {
    feedbackTimer--;
    // If feedbackTimer hits 0, we do something special if it was correct
    if (feedbackTimer <= 0) {
        // If it was correct, move on to the next word
        if (feedbackMessage == "Correct!") {
            wordIndex++;

            RefreshPositions();
			if (instance_exists(oColourAutoSigner)) {
			    // Destroy all instances of oAutoSigner
			    with (oColourAutoSigner) {
			        instance_destroy();
			    }
			}			
			instance_create_layer(x, y, "Instances", oColourAutoSigner);			
        }
        feedbackMessage = ""; // clear message
    }
    return; // skip the rest of logic while feedback is displayed
}

// 2) Check mouse clicks if not in feedback mode
if (mouse_check_button_pressed(mb_left)) {
    var mx = mouse_x;
    var my = mouse_y;
    // We see which slot (if any) was clicked
    for (var i = 0; i < array_length_1d(slots); i++) {
        var slot = slots[i];
        var spr  = slot.sprite;
        if (spr == -1) continue; // no sprite

        // We can approximate a bounding box or use precise sprite checking
        var sprWidth  = sprite_get_width(spr);
        var sprHeight = sprite_get_height(spr);
        var left   = slot.x - sprWidth/2;
        var top    = slot.y - sprHeight/2;
        var right  = slot.x + sprWidth/2;
        var bottom = slot.y + sprHeight/2;

        if (mx > left && mx < right && my > top && my < bottom) {
            // This slot was clicked
            if (slot.correct) {
                // CORRECT
                feedbackMessage = "Correct!";
                feedbackTimer   = room_speed * 2; // 2 seconds
                show_debug_message("oColourController: Correct clicked.");
            } else {
                // INCORRECT
                feedbackMessage = "Incorrect!";
                feedbackTimer   = room_speed * 2; // 2 seconds
                show_debug_message("oColourController: Incorrect clicked.");
            }
            break; // stop checking other slots
        }
    }
}
