// oCurrentSignDisplay - Create Event

/// @description Initialize references for displaying the current sign sprite

// Find the first instance of oLetterOnDashes to access its variables
letterOnDashesInstance = instance_find(oLetterOnDashes, 0);

if (!instance_exists(letterOnDashesInstance)) {
    show_debug_message("Debug: oLetterOnDashes instance not found. oCurrentSignDisplay may not function correctly.");
}
