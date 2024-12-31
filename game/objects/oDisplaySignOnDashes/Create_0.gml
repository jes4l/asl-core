// oDisplaySignOnDashes - Create Event

/// @description Initialize references for displaying signs on top of letters

// Find the first instance of oLetterOnDashes
letterOnDashesInstance = instance_find(oLetterOnDashes, 0);

// Check if oLetterOnDashes exists
if (!instance_exists(letterOnDashesInstance)) {
    show_debug_message("oLetterOnDashes instance not found. oDisplaySignOnDashes will not function correctly.");
}
