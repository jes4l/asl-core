// oCurrentLetterDisplay - Create Event

/// @description Initialize references for displaying the current letter

// Find the first instance of oLetterOnDashes to access its variables
letterOnDashesInstance = instance_find(oLetterOnDashes, 0);

if (!instance_exists(letterOnDashesInstance)) {
    show_debug_message("oLetterOnDashes instance not found.");
}
