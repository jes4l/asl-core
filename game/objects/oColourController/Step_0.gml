if (feedbackTimer > 0) {
    feedbackTimer--;
    if (feedbackTimer <= 0) {
        if (feedbackMessage == "Correct!") {
            var currentWord = global.activeWords[wordIndex];
            var upperWord = string_upper(currentWord);
            if (instance_exists(oSpriteSpawnColour)) {
                var spawn = instance_find(oSpriteSpawnColour, 0);
                if (spawn.incorrectCount == 0) {
					global.score += 20;
                    global.scoreGained += 20;
                    for (var i = 1; i <= string_length(upperWord); i++) {
                        ds_list_add(global.correctLetters, string_copy(upperWord, i, 1));
                    }
                } else if (spawn.incorrectCount == 1) {
					global.score += 10;
                    global.scoreGained += 10;
                    for (var i = 1; i <= string_length(upperWord); i++) {
                        ds_list_add(global.wrongLetters, string_copy(upperWord, i, 1));
                    }
                } else {
                    for (var i = 1; i <= string_length(upperWord); i++) {
                        var letter = string_copy(upperWord, i, 1);
                        ds_list_add(global.wasWrongLetters, letter);
                        var index = ds_list_find_index(global.wrongLetters, letter);
                        if (index != -1) {
                            ds_list_delete(global.wrongLetters, index);
                        }
                    }
                }
            }
            wordIndex++;
            RefreshPositions();
            if (wordIndex >= array_length_1d(global.activeWords)) {
                global.gameComplete = true;
                if (instance_exists(oBlankTube)) {
                    with (oBlankTube) {
                        array_copy(global.finalSegments, 0, testTubeSegments, 0, 4);
                        global.finalSegmentCount = segmentCount;
                    }
                }
            }
            if (instance_exists(oColourAutoSigner)) {
                with (oColourAutoSigner) {
                    instance_destroy();
                }
            }
            instance_create_layer(x, y, "Instances", oColourAutoSigner);
            if (instance_exists(oSpriteSpawnColour)) {
                with (oSpriteSpawnColour) {
                    incorrectCount = 0;
                }
            }
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
        var top = slot.y - sprHeight / 2;
        var right = slot.x + sprWidth / 2;
        var bottom = slot.y + sprHeight / 2;
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
                feedbackTimer = room_speed * 2;
                if (instance_exists(oSpriteSpawnColour)) {
                    with (oSpriteSpawnColour) {
                        if (incorrectCount < 2) {
                            incorrectCount++;
                        }
                    }
                }
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
