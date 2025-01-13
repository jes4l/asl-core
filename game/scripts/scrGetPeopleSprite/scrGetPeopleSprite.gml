/// scrGetRoleSprite(_word)
/// @description Updates the sprite based on the current word.
/// @param _word The current word to map to a sprite.

function scrGetPeopleSprite(_word) {
    // Capitalize the first letter to match sprite naming conventions
    var capitalizedWord = string_upper(string_char_at(_word, 1)) + string_delete(_word, 1, 1);
    
    // Construct the sprite name
    var spriteName = "s" + capitalizedWord;
    var spriteIndex = asset_get_index(spriteName);
    if (spriteIndex != -1) {
        sprite_index = spriteIndex;
        
        // Debug Message
        show_debug_message("Sprite updated to '" + spriteName + "'.");
    } else {
        // If the sprite doesn't exist, log a debug message
        show_debug_message("Sprite '" + spriteName + "' not found for word '" + _word + "'.");
        
        // Assign a default sprite
        sprite_index = sBoard;
        
    }
}
