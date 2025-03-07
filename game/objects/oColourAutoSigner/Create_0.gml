if (!instance_exists(oColourController)) {
    show_debug_message("oAutoSigner: No oColourController found! Destroying self.");
    instance_destroy();
    return;
}

var controller = instance_find(oColourController, 0);

if (!is_array(global.activeWords) || array_length_1d(global.activeWords) == 0) {
    show_debug_message("oAutoSigner: No active words. Destroying self.");
    instance_destroy();
    return;
}

if (controller.wordIndex < 0 || controller.wordIndex >= array_length_1d(global.activeWords)) {
    show_debug_message("oAutoSigner: wordIndex out of range (" + string(controller.wordIndex) + "). Destroying self.");
    instance_destroy();
    return;
}

var wordIndex = controller.wordIndex; 
word = global.activeWords[wordIndex];

letters = [];
sprites = [];
for (var i = 1; i <= string_length(word); i++) {
    var letter = string_char_at(word, i);
    array_push(letters, letter);

    var spr = scrGetASLSprite(letter);
    array_push(sprites, spr);
}

letterCount = array_length_1d(letters);
show_debug_message("oAutoSigner: Word = '" + word + "' (Total letters: " + string(letterCount) + ")");

if (letterCount == 0) {
    show_debug_message("oAutoSigner: Word '" + word + "' has no letters. Destroying self.");
    instance_destroy();
    return;
}

index = 0;

global.currentSignSprite = sprites[0];
show_debug_message("oAutoSigner: Displaying first letter '" + letters[0] + "'");

index = 1;
alarm[0] = room_speed * 5;
