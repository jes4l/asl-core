if (keyboard_check_pressed(ord("P"))) {
    room_goto(rmMenu);
}

var left = keyboard_check(vk_left);
var right = keyboard_check(vk_right);
var accelerate = keyboard_check(vk_up);
var brake = keyboard_check(vk_down);

if (left) direction += 2;
if (right) direction -= 2;

if (accelerate) {
    speed = 3;
} else if (brake) {
    speed = -3;
} else {
    speed = 0;
}

image_angle = direction;

var new_x = x + lengthdir_x(speed, direction);
var new_y = y + lengthdir_y(speed, direction);

if (place_meeting(new_x, new_y, oPath)) {
    x = new_x;
    y = new_y;
} else {
    speed = 0;
}