// oCurrentSignDisplay - Draw Event

/// @description Draw the current sign language sprite to be performed

// First, draw the object itself (if it has a sprite)
draw_self();

// Check if there's a valid sprite to draw
if (currentSignSprite != -1) {
    // Draw the current sign sprite at the object's position
    draw_sprite(currentSignSprite, 0, x, y);
} else {
	show_debug_message("Sprite not Found");
}
