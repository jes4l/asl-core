/// scr_draw_centered_text_ex(_x, _y, _text, _color, _alpha = 1, _font = undefined)
/// @description Draws centered text with optional alpha and font without affecting global drawing settings.
/// @param _x       The x-coordinate where the text should be drawn.
/// @param _y       The y-coordinate where the text should be drawn.
/// @param _text    The string of text to draw.
/// @param _color   The color of the text.
/// @param _alpha   The alpha value of the text (default is 1).
/// @param _font    The font to use for the text (default is current font).

function scrDrawText(_x, _y, _text, _color, _alpha, _font) {
    if (_alpha == undefined) {
        _alpha = 1;
    }
    
    // Debug message (optional)
    // show_debug_message("Drawing text '" + _text + "' at (" + string(_x) + ", " + string(_y) + ") with color " + string(_color) + " and alpha " + string(_alpha));
    
    // Save current drawing settings
    var prev_halign = draw_get_halign();
    var prev_valign = draw_get_valign();
    var prev_color  = draw_get_color();
    var prev_font   = draw_get_font();
    var prev_alpha  = draw_get_alpha();
    
    // Set new drawing settings for centered text
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_color(_color);
    
    // Set font if provided
    if (_font != undefined) {
        draw_set_font(_font);
    }
    
    // Set alpha
    draw_set_alpha(_alpha);
    
    // Draw the text
    draw_text(_x, _y, _text);
    
    // Restore previous drawing settings
    draw_set_halign(prev_halign);
    draw_set_valign(prev_valign);
    draw_set_color(prev_color);
    draw_set_font(prev_font);
    draw_set_alpha(prev_alpha);
    
    // Debug message (optional)
    // show_debug_message("Restored previous drawing settings.");
}
