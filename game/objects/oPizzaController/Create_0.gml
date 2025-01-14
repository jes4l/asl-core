// oRoleController - Create Event

/// @description Initialize Role Controller

letterController = instance_find(oLetterOnDashes, 0);
if (letterController != noone) {
    previousWord = "";
} else {
    show_debug_message("oRoleController Error: No instance of oLetterOnDashes found.");
}

previousWordSprites = ds_list_create();
