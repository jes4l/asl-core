// oAutoSigner - Create Event

/// @description Initialize Auto Signer
global.currentSignSprite = "";
if (is_array(global.activeWords) && array_length_1d(global.activeWords) > 0) {
    word = global.activeWords[oColourController.wordIndex];
    
    // Break word into individual letters
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
    show_debug_message("oAutoSigner: Word = " + word + " (Total letters: " + string(letterCount) + ")");

    // If no letters, just skip
    if (letterCount == 0) {
        instance_destroy();
        return;
    }
    
    // Index for the letter we are currently displaying
    index = 0;
    
    // Display the first letter immediately (0-5 sec)
    global.currentSignSprite = sprites[0];
    
    // Next alarm in 5 seconds to handle letter 1
    index = 1; 
    alarm[0] = room_speed * 5;
    
} else {
    show_debug_message("No active words. Destroying self.");
    instance_destroy();
}
