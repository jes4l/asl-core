/// scrGetASLSprite(_letter)
/// @description Retrieves the sprite index for the given ASL letter. Logs an error if the sprite is not found.
/// @param _letter The character representing the ASL letter (e.g., 'A', 'B', 'C').

function scrGetASLSprite(_letter) {
    // Validate input
    if (!is_string(_letter) || string_length(_letter) != 1) {
        show_debug_message("scrGetASLSprite Error: Invalid input. Expected a single character string.");
        return -1;
    }

    // Convert to uppercase to match sprite naming convention
    var upperLetter = string_upper(_letter);

    // Construct the sprite name based on the naming convention (e.g., 'A' -> 'sAASL')
    var spriteName = "s" + upperLetter + "ASL";

    // Retrieve the sprite index using the sprite name
    var spriteIndex = asset_get_index(spriteName);

    // Check if the sprite exists
    if (spriteIndex == -1) {
        show_debug_message("scrGetASLSprite Warning: Sprite '" + spriteName + "' not found.");
        return -1;
    }

    return spriteIndex;
}
