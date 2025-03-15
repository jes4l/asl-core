/// scrGetWordPoolSprite(_word, _setSprite)
/// @description Retrieves/returns the sprite index for the given word. 
/// If _setSprite is true, also sets the calling instance’s sprite_index.
///
/// @param _word       The current word to map to a sprite (e.g., "mango").
/// @param _setSprite  Boolean: if true, sets the instance's sprite_index. Default = true.
///
/// @return The sprite index, or sBoard if not found.

function scrGetWordPoolSprite(_word, _setSprite) {
    if (_setSprite == undefined) {
        _setSprite = true;
    }
    
    if (!is_string(_word) || string_length(_word) < 1) {
        //show_debug_message("scrGetWordPoolSprite: Invalid or empty word. Using sBoard.");
        if (_setSprite) {
            sprite_index = sBoard;
        }
        return sBoard;
    }

    var capitalizedWord = string_upper(string_char_at(_word, 1)) + string_delete(_word, 1, 1);
    var spriteName = "s" + capitalizedWord;
    var spIndex    = asset_get_index(spriteName);

    if (spIndex == -1) {
        //show_debug_message("scrGetWordPoolSprite: Sprite '" + spriteName + "' not found for word '" + _word + "'. Using sBoard.");
        spIndex = sBoard;
    } else {
        //show_debug_message("scrGetWordPoolSprite: Sprite updated to '" + spriteName + "'.");
    }

    if (_setSprite) {
        sprite_index = spIndex;
    }
    return spIndex;
}
