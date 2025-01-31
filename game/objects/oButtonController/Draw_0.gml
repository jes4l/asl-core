// oButtonController - Draw Event

// Reset alpha to 1 to prevent residual transparency
draw_set_alpha(0.5);

// Set the font once
draw_set_font(fntButton);

for (var i = 0; i < array_length_1d(buttonData); i++) {
    var btn = buttonData[i];
    
    // Draw button border
    draw_set_color(c_black);
    draw_rectangle(btn.x1, btn.y1, btn.x2, btn.y2, false);
    
    // Draw button background
    draw_set_color(c_white);
    draw_rectangle(btn.x1, btn.y1, btn.x2, btn.y2, true);
    
    // Calculate center positions for better alignment
    var centerX = btn.x1 + (btn.width / 2);
    var centerY = btn.y1 + (btn.height / 2);
    
    // Use the enhanced helper function to draw centered text with font
    scrDrawText(
        centerX,                     // x-coordinate
        centerY,                     // y-coordinate
        btn.text,                    // text to draw
        c_white,                     // color
        1,                           // alpha value
        fntButton                    // font to use
    );
}
