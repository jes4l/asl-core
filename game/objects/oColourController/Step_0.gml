if (feedbackTimer > 0) {
    feedbackTimer--;
    if (feedbackTimer <= 0) {
        if (feedbackMessage == "Correct!") {
            wordIndex++;
            RefreshPositions();
            if (wordIndex >= array_length_1d(global.activeWords)) {
                global.gameComplete = true;
            }
            if (instance_exists(oColourAutoSigner)) {
                with (oColourAutoSigner) {
                    instance_destroy();
                }
            }
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
        var sprWidth = sprite_get_width(slot.sprite);
        var sprHeight = sprite_get_height(slot.sprite);
        var left = slot.x - sprWidth / 2;
        var top = slot.y - sprHeight/2;
        var right = slot.x + sprWidth / 2;
        var bottom = slot.y + sprHeight/2;
        if (mx > left && mx < right && my > top && my < bottom) {
            if (slot.correct) {
                feedbackMessage = "Correct!";
                feedbackTimer = room_speed * 2;
                if (instance_exists(oBlankTube)) {
                    with (oBlankTube) {
                        AddPartialSegment(slot.sprite);
                    }
                }
                show_debug_message("oColourController: Correct clicked => partial segment added!");
            } else {
                feedbackMessage = "Incorrect!";
                feedbackTimer = room_speed * 1;
            }
            break;
        }
    }
}

if (global.gameComplete) {
    if (mixingTimer == 0) {
        mixingTimer = room_speed * 2;
    }
    mixingTimer--;
    if (mixingTimer <= 0) {
        room_goto(rmColourGameEnd);
    }
}