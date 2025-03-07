if (keyboard_check_pressed(vk_space)) {
    if (currentPoint < totalPoints - 1) {
        currentPoint++;
    } else {
        room_goto(rmColourGame);
    }
}
