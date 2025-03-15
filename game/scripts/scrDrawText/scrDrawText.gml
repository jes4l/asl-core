/// @description Draws centered text with optional alpha and font without affecting global drawing settings.
/// @param xText       The x-coordinate where the text should be drawn.
/// @param yText       The y-coordinate where the text should be drawn.
/// @param stringText  The string of text to draw.
/// @param colourText  The color of the text.
/// @param alphaText   The alpha value of the text
/// @param fontText    The font to use for the text

function scrDrawText(xText, yText, stringText, colourText, alphaText, fontText) {
    if (alphaText == undefined) {
        alphaText = 1;
    }
    
    // show_debug_message("Drawing text '" + stringText + "' at (" + string(xText) + ", " + string(yText) + ") with color " + string(colourText) + " and alpha " + string(alphaText));
    
    var prevHalign = draw_get_halign();
    var prevValign = draw_get_valign();
    var prevColour  = draw_get_color();
    var prevFont   = draw_get_font();
    var prevAlpha  = draw_get_alpha();
    
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_color(colourText);
    
    if (fontText != undefined) {
        draw_set_font(fontText);
    }
    
    draw_set_alpha(alphaText);
    
    draw_text(xText, yText, stringText);
    
    draw_set_halign(prevHalign);
    draw_set_valign(prevValign);
    draw_set_color(prevColour);
    draw_set_font(prevFont);
    draw_set_alpha(prevAlpha);
    
}
