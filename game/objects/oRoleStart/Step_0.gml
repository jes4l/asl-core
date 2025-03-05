if (keyboard_check_pressed(vk_space)) {
    if (currentPoint < totalPoints - 1) {
        currentPoint++;
    } else {
        room_goto(rmRoleGame);
    }
}
if (currentPoint == 2 && computerInst == noone) {
    computerInst = instance_create_layer(1376,752,"Instances_3", oComputer);
    computerInst.image_xscale = 0.8;
    computerInst.image_yscale = 0.8;
}
if (currentPoint == 3 && computerInst != noone) {
    instance_destroy(computerInst);
    computerInst = noone;
}
if (currentPoint == 3 && signTimerInst == noone) {
    signTimerInst = instance_create_layer(128,160,"Instances_3", oRoleSignTimer);
    signTimerInst.image_xscale = 1;
    signTimerInst.image_yscale = 1;
}
if (currentPoint == 4 && signTimerInst != noone) {
    instance_destroy(signTimerInst);
    signTimerInst = noone;
}
