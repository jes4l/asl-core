var listObj = instance_find(oGameWordList, 0);
if (!instance_exists(listObj)) {
    return;
}

var word = ds_list_find_value(listObj.wordsList, 0);
var letterCount = string_length(word);
var totalWidth = 0.6 * room_width;
var dashSpacing = totalWidth / letterCount;
var startX = (room_width - totalWidth) * 0.5; 
var startY = room_height * 0.5;

for (var i = 0; i < letterCount; i++) {
    var dashX = startX + i * dashSpacing; 
    var c = string_char_at(word, i + 1);

    if (c != " ") {
        draw_text(dashX, startY, "_");
    }
}
