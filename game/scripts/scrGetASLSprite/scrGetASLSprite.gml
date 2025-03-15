/// scrGetASLSprite(_letter)
/// @description Retrieves the sprite index for the given ASL letter. Logs an error if the sprite is not found.
/// @param _letter The character representing the ASL letter (e.g., 'A', 'B', 'C')(e.g., 'A' -> 'sAASL')

function scrGetASLSprite(_letter) {
    if (!is_string(_letter) || string_length(_letter) != 1) {
        show_debug_message("scrGetASLSprite Error: Invalid input. Expected a single character string.");
        return -1;
    }

    var upperLetter = string_upper(_letter);
    var spriteName = "s" + upperLetter + "ASL";
    var spriteIndex = asset_get_index(spriteName);
    if (spriteIndex == -1) {
        show_debug_message("scrGetASLSprite Warning: Sprite '" + spriteName + "' not found.");
        return -1;
    }

    return spriteIndex;
}
