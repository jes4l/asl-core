letterController = instance_find(oLetterOnDashes, 0);
if (letterController != noone) {
    previousWord = "";
}
loadedSprites = ds_list_create();
incorrectSprites = ds_list_create();
processingTimer = -1;
newSpriteLoaded = false;
baseX = x;
