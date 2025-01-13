// oRoleController - Create Event

/// @description Initialize Role Controller

// Reference to the oLetterOnDashes instance
letterController = instance_find(oLetterOnDashes, 0);

if (letterController != noone) {
    previousWord = "";
} else {
    show_debug_message("No instance of oLetterOnDashes found.");
}
