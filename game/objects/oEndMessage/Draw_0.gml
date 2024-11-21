function removePunctuation(word) {
    var cleanedWord = "";
    for (var i = 1; i <= string_length(word); i++) {
        var char = string_char_at(word, i);
        if ((char >= "A" && char <= "Z") || (char >= "a" && char <= "z")) {
            cleanedWord += char;
        }
    }
    return cleanedWord;
}

var originalFont = draw_get_font();
var originalColor = draw_get_color();

draw_set_font(fnt_letter_smallest);

var roomWidth = room_width;
var margin = 10;

var words = string_split(global.pizzaOrderEnd, " ");
var currentLine = "";
var lines = [];
var lineWidth = 0;

for (var i = 0; i < array_length(words); i++) {
    var word = words[i];
    var testLine = currentLine == "" ? word : currentLine + " " + word;
    var testWidth = string_width(testLine);
    
    if (testWidth > roomWidth - 2 * margin) {
        array_push(lines, currentLine);
        currentLine = word;
    } else {
        currentLine = testLine;
    }
}

if (currentLine != "") {
    array_push(lines, currentLine);
}

var textY = 30;
for (var i = 0; i < array_length(lines); i++) {
    var line = lines[i];
    var lineWidth = string_width(line);
    var textX = (roomWidth - lineWidth) / 2;
    
    var lineWords = string_split(line, " ");
    var textXOffset = textX;
    
    for (var j = 0; j < array_length(lineWords); j++) {
        var lineWord = lineWords[j];
        var cleanedWord = removePunctuation(lineWord);
        if (array_contains(global.wordList, cleanedWord)) {
            draw_set_color(c_green);
        } else {
            draw_set_color(c_black);
        }
        draw_text(textXOffset, textY, lineWord);
        textXOffset += string_width(lineWord + " ");
    }
    
    textY += string_height(line);
}

draw_set_font(originalFont);
draw_set_color(originalColor);