var wrap_text = function(text, max_width) {
    var lines = [];
    var segments = string_split(text, "\n");
    for (var seg = 0; seg < array_length(segments); seg++) {
        var segment = segments[seg];
        var words = [];
        var start = 1;
        for (var i = 1; i <= string_length(segment); i++) {
            if (string_char_at(segment, i) == " ") {
                var word = string_copy(segment, start, i - start);
                if (word != "") {
                    array_push(words, word);
                }
                start = i + 1;
            }
        }
        var last_word = string_copy(segment, start, string_length(segment) - start + 1);
        if (last_word != "") {
            array_push(words, last_word);
        }
        var current_line_words = [];
        var current_line_width = 0;
        for (var i = 0; i < array_length(words); i++) {
            var word = words[i];
            var word_width = string_width(word);
            if (current_line_width + word_width > max_width) {
                if (array_length(current_line_words) > 0) {
                    var line_text = "";
                    for (var j = 0; j < array_length(current_line_words); j++) {
                        line_text += current_line_words[j] + " ";
                    }
                    line_text = string_copy(line_text, 1, string_length(line_text) - 1);
                    array_push(lines, line_text);
                }
                current_line_words = [word];
                current_line_width = word_width + string_width(" ");
            } else {
                array_push(current_line_words, word);
                current_line_width += word_width + string_width(" ");
            }
        }
        if (array_length(current_line_words) > 0) {
            var line_text = "";
            for (var j = 0; j < array_length(current_line_words); j++) {
                line_text += current_line_words[j] + " ";
            }
            line_text = string_copy(line_text, 1, string_length(line_text) - 1);
            array_push(lines, line_text);
        }
        if (seg < array_length(segments) - 1) {
            array_push(lines, "");
        }
    }
    return lines;
};

for (var i = 0; i < array_length_1d(buttonData); i++) {
    var btn = buttonData[i];
    var isHovered = (i == hoveredIndex);
    var rotSectorStart = btn.sectorStart;
    var rotSectorEnd = btn.sectorEnd;
    var sectorColor = isHovered ? c_white : c_gray;
    draw_set_alpha(isHovered ? 0.8 : 0.4);
    draw_set_color(sectorColor);
    var steps = 20;
    var angDiff = (rotSectorEnd >= rotSectorStart) ? (rotSectorEnd - rotSectorStart) : ((2*pi - rotSectorStart) + rotSectorEnd);
    var angleStep = angDiff / steps;
    for (var j = 0; j < steps; j++) {
        var a1 = rotSectorStart + j * angleStep;
        var a2 = rotSectorStart + (j + 1) * angleStep;
        var ox1 = centerX + outerRadius * cos(a1);
        var oy1 = centerY + outerRadius * sin(a1);
        var ox2 = centerX + outerRadius * cos(a2);
        var oy2 = centerY + outerRadius * sin(a2);
        var ix1 = centerX + innerRadius * cos(a1);
        var iy1 = centerY + innerRadius * sin(a1);
        draw_primitive_begin(pr_trianglelist);
        draw_vertex(ox1, oy1);
        draw_vertex(ox2, oy2);
        draw_vertex(ix1, iy1);
        draw_primitive_end();
        var ix2 = centerX + innerRadius * cos(a2);
        var iy2 = centerY + innerRadius * sin(a2);
        draw_primitive_begin(pr_trianglelist);
        draw_vertex(ix1, iy1);
        draw_vertex(ox2, oy2);
        draw_vertex(ix2, iy2);
        draw_primitive_end();
    }
    draw_set_alpha(1);
    draw_set_color(c_black);
    for (var j = 0; j < steps; j++) {
        var a1 = rotSectorStart + j * angleStep;
        var a2 = rotSectorStart + (j + 1) * angleStep;
        var ox1 = centerX + outerRadius * cos(a1);
        var oy1 = centerY + outerRadius * sin(a1);
        var ox2 = centerX + outerRadius * cos(a2);
        var oy2 = centerY + outerRadius * sin(a2);
        var ix1 = centerX + innerRadius * cos(a1);
        var iy1 = centerY + innerRadius * sin(a1);
        var ix2 = centerX + innerRadius * cos(a2);
        var iy2 = centerY + innerRadius * sin(a2);
        draw_line(ox1, oy1, ox2, oy2);
        draw_line(ix1, iy1, ix2, iy2);
    }
    var rx1 = centerX + outerRadius * cos(rotSectorStart);
    var ry1 = centerY + outerRadius * sin(rotSectorStart);
    var rx2 = centerX + innerRadius * cos(rotSectorStart);
    var ry2 = centerY + innerRadius * sin(rotSectorStart);
    draw_line(rx1, ry1, rx2, ry2);
    var rx3 = centerX + outerRadius * cos(rotSectorEnd);
    var ry3 = centerY + outerRadius * sin(rotSectorEnd);
    var rx4 = centerX + innerRadius * cos(rotSectorEnd);
    var ry4 = centerY + innerRadius * sin(rotSectorEnd);
    draw_line(rx3, ry3, rx4, ry4);
    var midAngle = (rotSectorStart <= rotSectorEnd) ? (rotSectorStart + rotSectorEnd) / 2 : (((rotSectorStart + (rotSectorEnd + 2*pi)) / 2) mod (2*pi));
    var spriteRadius = (innerRadius + outerRadius) / 2;
    var spriteX = centerX + spriteRadius * cos(midAngle);
    var spriteY = centerY + spriteRadius * sin(midAngle);
    var numFrames = sprite_get_number(btn.sprite);
    var subimg_to_draw = isHovered ? floor(animFrame) % numFrames : 0;
    var scale = isHovered ? 1.2 : 1;
    var color = isHovered ? c_gray : c_white;
    draw_sprite_ext(btn.sprite, subimg_to_draw, spriteX, spriteY, scale, scale, 0, color, 1);
}

if (hoveredIndex != -1) {
    var padding = innerRadius * 0.1;
    var availableWidth = 2 * (innerRadius - padding);
    draw_set_halign(fa_center);
    draw_set_valign(fa_top);
    draw_set_color(c_white);
    draw_set_font(fntBritanicBold30);
    var gameLineHeight = string_height("A");
    var gameNameLines = wrap_text(buttonData[hoveredIndex].text, availableWidth);
    var totalGameNameHeight = (array_length(gameNameLines) - 1) * gameLineHeight * 1.2 + gameLineHeight;
    var gameNameY = centerY - innerRadius * 0.7;
    for (var i = 0; i < array_length(gameNameLines); i++) {
        var gameLineY = gameNameY + i * gameLineHeight * 1.2;
        draw_text(centerX, gameLineY, gameNameLines[i]);
    }
    draw_set_font(fntBritanicBold20);
    var descLineHeight = string_height("A");
    var descriptionStartY = gameNameY + totalGameNameHeight + descLineHeight * 0.3;
    var descLines = wrap_text(buttonData[hoveredIndex].description, availableWidth);
    for (var i = 0; i < array_length(descLines); i++) {
        var descLineY = descriptionStartY + i * descLineHeight * 1.2;
        draw_text(centerX, descLineY, descLines[i]);
    }
} else {
    draw_sprite(sASLCoreLogoMenu, 0, centerX, centerY);
}

draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_alpha(1);