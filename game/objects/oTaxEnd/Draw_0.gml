draw_self();

var original_font = draw_get_font();
var original_color = draw_get_color();

var objWidth = bbox_right - bbox_left;
var objHeight = bbox_bottom - bbox_top;

var centerX = x + objWidth / 2;
var topY = y + 40;

var taxFormText = "Tax Form";
draw_set_font(fnt_letter_smallest);
var taxFormWidth = string_width(taxFormText);
draw_text(centerX - taxFormWidth / 2, topY, taxFormText);

var identifiedText = "You have identified:";
draw_set_font(fnt_letter_smallest_smallest);
var identifiedTextWidth = string_width(identifiedText);
draw_text(centerX - identifiedTextWidth / 2, topY + string_height(taxFormText) + 10, identifiedText);

var listY = topY + string_height(taxFormText) + 10 + string_height(identifiedText) + 5;
if (ds_map_exists(global.gameWordLists, "roleGame")) {
    var roleGameList = global.gameWordLists[? "roleGame"];
    draw_set_color(c_green);
    for (var i = 0; i < array_length_1d(roleGameList); i++) {
        var word = roleGameList[i];
        draw_text(x + 40, listY, "- " + word);
        listY += string_height(word) + 5;
    }
    draw_set_color(original_color);
}

draw_set_font(original_font);
draw_set_color(original_color);
