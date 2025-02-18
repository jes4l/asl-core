/// @function scrDrawCircularText(cx, cy, radius, angleCenter, text, col, alp, font)
/// @desc Draws the given text along a circular arc.
/// @param cx       The x-coordinate of the circle’s center.
/// @param cy       The y-coordinate of the circle’s center.
/// @param radius   The radius at which to draw the text.
/// @param angleCenter The central angle (in degrees) of the text arc.
/// @param text     The string to draw.
/// @param col      The color for the text.
/// @param alp      The alpha value.
/// @param font     The font to use.

function scrDrawCircularText(cx, cy, radius, angleCenter, text, col, alp, font) {
    // Set drawing properties.
    draw_set_font(font);
    draw_set_color(col);
    draw_set_alpha(alp);
    
    // Compute the total width (in pixels) of the text.
    var totalWidth = string_width(text);
    // Convert that length into an angular span (in degrees).
    var arcAngle = (totalWidth / radius) * (180 / pi);
    
    // Calculate the starting angle so the text is centered on angleCenter.
    var startAngle = angleCenter - arcAngle / 2;
    
    var currentAngle = startAngle;
    // Loop through each letter.
    for (var i = 1; i <= string_length(text); i++) {
         var letter = string_char_at(text, i);
         var letterWidth = string_width(letter);
         // The angular span for this letter.
         var letterArc = (letterWidth / radius) * (180 / pi);
         // Place the letter at the center of its arc segment.
         var letterAngle = currentAngle + letterArc / 2;
         
         // Calculate the letter’s position along the circle.
         var lx = cx + lengthdir_x(radius, letterAngle);
         var ly = cy + lengthdir_y(radius, letterAngle);
         
         // Rotate the letter so it’s tangent to the circle.
         // (Tangent = letterAngle + 90°)
         var letterRotation = letterAngle + 90;
         
         // Draw the letter rotated.
         // *** IMPORTANT: *** You must have a function named draw_text_rotated
         // (or an equivalent implementation) since GameMaker doesn't support rotated text out-of-the-box.
         draw_text_rotated(lx, ly, letter, letterRotation);
         
         // Advance currentAngle by the angular span of this letter.
         currentAngle += letterArc;
    }
}
