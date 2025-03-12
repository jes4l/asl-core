letterOnDashesInstance = instance_find(oLetterOnDashes, 0);

if (!instance_exists(letterOnDashesInstance)) {
    show_debug_message("oLetterOnDashes instance not found. oCurrentSignDisplay may not function correctly.");
}

currentSignSprite = -1;
