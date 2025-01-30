global.currentSignSprite = "";

if (is_array(global.activeWords) && array_length_1d(global.activeWords) > 0) {
    word = global.activeWords[0];
    
    letters = [];
    sprites = [];
    for (var i = 1; i <= string_length(word); i++) {
        var letter = string_char_at(word, i);
        array_push(letters, letter);
        
        var spr = scrGetASLSprite(letter);
        array_push(sprites, spr);
    }
    
    letterCount = array_length_1d(letters);
    show_debug_message("oAutoSigner: Word = " + word + " (Total letters: " + string(letterCount) + ")");

    if (letterCount == 0) {
        instance_destroy();
        return;
    }
	
    index = 0;
    global.currentSignSprite = sprites[0];
    index = 1; 
    alarm[0] = room_speed * 5;
    
} else {
    show_debug_message("No active words. Destroying self.");
    instance_destroy();
}
