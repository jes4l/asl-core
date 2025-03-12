draw_self();

if (currentSignSprite != -1) {
    draw_sprite(currentSignSprite, 0, x, y);
} else {
	show_debug_message("Sprite not Found");
}
