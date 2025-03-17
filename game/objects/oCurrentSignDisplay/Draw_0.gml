draw_self();

if (currentSignSprite != -1) {
draw_sprite_ext(currentSignSprite, 0, x, y, 0.80, 0.80, 0, c_white, 1);
} else {
	show_debug_message("Sprite not Found");
}
