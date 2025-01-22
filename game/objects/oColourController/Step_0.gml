// oColourController - Step Event

/// @description Checks for clicks on the 4 sprites, handles feedback timer

if (feedbackTimer > 0) {
    feedbackTimer--;
    if (feedbackTimer <= 0) {
        if (feedbackMessage == "Correct!") {
            wordIndex++;
            RefreshPositions();

            // Destroy existing oColourAutoSigner
            if (instance_exists(oColourAutoSigner)) {
                with (oColourAutoSigner) {
                    instance_destroy();
                }
            }
            // Create a new oColourAutoSigner
            instance_create_layer(x, y, "Instances", oColourAutoSigner);
        }
        feedbackMessage = "";
    }
    return;
}

if (mouse_check_button_pressed(mb_left)) {
    var mx = mouse_x;
    var my = mouse_y;
    for (var i = 0; i < array_length_1d(slots); i++) {
        var slot = slots[i];
        if (slot.sprite == -1) continue;

        var sprWidth  = sprite_get_width(slot.sprite);
        var sprHeight = sprite_get_height(slot.sprite);
        var left   = slot.x - sprWidth / 2;
        var top    = slot.y - sprHeight/2;
        var right  = slot.x + sprWidth / 2;
        var bottom = slot.y + sprHeight/2;

        if (mx > left && mx < right && my > top && my < bottom) {
            if (slot.correct) {
                // CORRECT
                feedbackMessage = "Correct!";
                feedbackTimer   = room_speed * 2;

                // We call AddPartialSegment(...) on oBlankTubeOverlay, passing the correct color
                if (instance_exists(oBlankTube)) {
                    with (oBlankTube) {
                        AddPartialSegment(slot.sprite);
                    }
                }
                show_debug_message("oColourController: Correct clicked => partial segment added!");
            } else {
                // INCORRECT
                feedbackMessage = "Incorrect!";
                feedbackTimer   = room_speed * 2;
                show_debug_message("oColourController: Incorrect clicked.");
            }
            break; // stop checking
        }
    }
}
