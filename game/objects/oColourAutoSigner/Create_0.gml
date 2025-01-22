// oAutoSigner - Create Event

/// @description Initialize Auto Signer for the word at oColourController.wordIndex

// 1) Check for oColourController instance
if (!instance_exists(oColourController)) {
    show_debug_message("oAutoSigner: No oColourController found! Destroying self.");
    instance_destroy();
    return;
}

// 2) Reference the oColourController object
var controller = instance_find(oColourController, 0);

// 3) Ensure global.activeWords is valid
if (!is_array(global.activeWords) || array_length_1d(global.activeWords) == 0) {
    show_debug_message("oAutoSigner: No active words. Destroying self.");
    instance_destroy();
    return;
}

// 4) Check if controller.wordIndex is in range
if (controller.wordIndex < 0 || controller.wordIndex >= array_length_1d(global.activeWords)) {
    show_debug_message("oAutoSigner: wordIndex out of range (" + string(controller.wordIndex) + "). Destroying self.");
    instance_destroy();
    return;
}

// 5) Retrieve the current word
var wordIndex = controller.wordIndex; 
word = global.activeWords[wordIndex];

// 6) Break the word into letters and map them to ASL sprites
letters = [];
sprites = [];
for (var i = 1; i <= string_length(word); i++) {
    var letter = string_char_at(word, i);
    array_push(letters, letter);

    // Get ASL sprite for this letter
    var spr = scrGetASLSprite(letter);
    array_push(sprites, spr);
}

letterCount = array_length_1d(letters);
show_debug_message("oAutoSigner: Word = '" + word + "' (Total letters: " + string(letterCount) + ")");

// 7) If no letters exist, destroy the instance
if (letterCount == 0) {
    show_debug_message("oAutoSigner: Word '" + word + "' has no letters. Destroying self.");
    instance_destroy();
    return;
}

// 8) Initialize the signing index
index = 0;

// 9) Display the first letter immediately (0–5 sec)
global.currentSignSprite = sprites[0];
show_debug_message("oAutoSigner: Displaying first letter '" + letters[0] + "'");

// 10) Schedule the next letter for 5 seconds later
index = 1;
alarm[0] = room_speed * 5;
