// oMenuButton - Draw Event

// Reset alpha to 1 to prevent residual transparency
draw_set_alpha(1);

// Set the font once
draw_set_font(fntButton);

// Draw the button border
draw_set_color(c_black);
draw_rectangle(x1, y1, x2, y2, false);

// Draw the button background
draw_set_color(c_white);
draw_rectangle(x1, y1, x2, y2, true);

// Calculate center positions for better alignment
var centerX = x1 + (buttonWidth / 2);
var centerY = y1 + (buttonHeight / 2);

// Use the enhanced helper function to draw centered text with font
scrDrawText(
    centerX,                     // x-coordinate
    centerY,                     // y-coordinate
    buttonText,                  // text to draw
    c_white,                     // color
    1,                           // alpha value
    fntButton                    // font to use
);
