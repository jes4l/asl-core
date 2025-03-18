if (noBags > 0 && variable_global_exists("correctWords") && array_length_1d(global.correctWords) == 0) {
    noBags -= 1;
}


if (keyboard_check_pressed(vk_space)) {
    global.scoreGained = 0;
    room_goto(rmFeedback);
}