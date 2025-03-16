if (displayStage == 0) {
    timer += 1;
    if (timer >= room_speed * 6) {
        timer = 0;
        displayStage = 1;
    }
} else if (displayStage == 1) {
    timer += 1;
    if (timer >= room_speed * 6) {
        timer = 0;
        if (hasCorrect && hasIncorrect) {
            displayStage = 2;
            with (oRoleDisplayCorrect) {
                instance_destroy();
            }
            if (!instance_exists(oRoleDisplayIncorrect)) {
                instance_create_layer(0, 0, "Instances_3", oRoleDisplayIncorrect);
            }
        } else {
            displayStage = 3;
        }
    }
} else if (displayStage == 2) {
    timer += 1;
    if (timer >= room_speed * 6) {
        timer = 0;
        displayStage = 3;
    }
} else if (displayStage == 3) {
    timer += 1;
    if (timer >= room_speed * 8) {
        global.oRoleGameSprites = undefined;
        global.oRoleGameIncorrectSprites = undefined;
        global.scoreGained = 0;
        room_goto(rmMenu);
    }
}