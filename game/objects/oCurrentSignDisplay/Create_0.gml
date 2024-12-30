// oCurrentSignDisplay - Create Event

/// @description Initialize references for displaying the current sign sprite

// Find the first instance of oLetterOnDashes to access its variables
letterOnDashesInstance = instance_find(oLetterOnDashes, 0);

// Optional: Handle the case where oLetterOnDashes does not exist
if (!instance_exists(letterOnDashesInstance)) {
    show_debug_message("oLetterOnDashes instance not found. oCurrentSignDisplay may not function correctly.");
}

// Initialize the current sprite to -1 (indicating no sprite)
currentSignSprite = -1;
