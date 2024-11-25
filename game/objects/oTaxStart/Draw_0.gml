draw_self();

var original_font = draw_get_font();
var original_color = draw_get_color();

var objWidth = bbox_right - bbox_left;
var topY = y + 40;

var jobFont = fnt_letter_smallest;
var infoFont = fnt_letter_smallest_smallest;

var centerX = x + objWidth / 2;

var padding = 40;
var wrapWidth = objWidth - 2 * padding;

var jobText = "Your Job";
draw_set_font(jobFont);
var jobTextWidth = string_width(jobText);
draw_text(centerX - jobTextWidth / 2, topY, jobText);

var listY = topY + string_height(jobText) + 20;

var infoText = "You must identify the jobs people do and fill them in the tax form";
draw_set_font(infoFont);

var words = string_split(infoText, " ");
var currentLine = "";

for (var i = 0; i < array_length_1d(words); i++) {
    var word = words[i];
    var testLine = currentLine + (currentLine == "" ? "" : " ") + word;

    if (string_width(testLine) <= wrapWidth) {
        currentLine = testLine;
    } else {
        draw_text(centerX - string_width(currentLine) / 2, listY, currentLine);
        listY += string_height(currentLine) + 5;
        currentLine = word;
    }
}

if (currentLine != "") {
    draw_text(centerX - string_width(currentLine) / 2, listY, currentLine);
}

draw_set_font(original_font);
draw_set_color(original_color);