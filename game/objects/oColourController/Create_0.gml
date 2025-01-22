// oColourController - Create Event

/// @description Initializes the positions, colourPool, and starts at wordIndex=0.

/// Example color pool with the relevant sprites 
/// (must match your naming and loaded resources)
colourPool   = [ sBlue, sBrown, sGreen, sOranges, sPink, sPurple, sRed, sWhite, sYellow];

/// The 4 fixed positions
positions = [
    { x: 666,  y: 350 },
    { x: 1066, y: 350 },
    { x: 1466, y: 350 },
    { x: 1866, y: 350 }
];

// Start with the first word in global.activeWords
wordIndex = 0;

// The array that holds which sprite goes in each of the 4 positions
slots = [];

// For the feedback message
feedbackMessage = "";
feedbackTimer   = 0;  // how many steps remain to display it


function RefreshPositions() 
{
    // 1) If we have no more words, no sprites
    if (wordIndex >= array_length_1d(global.activeWords)) {
        show_debug_message("oColourController: No more words left. All positions = none.");
        slots = [
            { sprite: -1, x: positions[0].x, y: positions[0].y, correct: false },
            { sprite: -1, x: positions[1].x, y: positions[1].y, correct: false },
            { sprite: -1, x: positions[2].x, y: positions[2].y, correct: false },
            { sprite: -1, x: positions[3].x, y: positions[3].y, correct: false }
        ];
        return;
    }

    // 2) Determine the active word (e.g., "mango") 
    var currentWord = global.activeWords[wordIndex];

    // 3) Convert that word to a sprite (scrGetWordPoolSprite or direct mapping)
    //    We'll use your scrGetWordPoolSpriteHy to retrieve it
    var activeSprite = scrGetWordPoolSprite(currentWord, false);

    // 4) Choose a random position index [0..3] for the active word
    var activeWordPosIndex = irandom_range(0, 3);

    // 5) Build a local array for slots. We'll fill them with { sprite, x, y, correct }
    slots = [];
    // Initialize all 4 with dummy data, we'll overwrite them
    for (var i = 0; i < 4; i++) {
        slots[i] = { 
            sprite: -1, 
            x: positions[i].x, 
            y: positions[i].y, 
            correct: false 
        };
    }

    // 6) Assign the active word sprite to the random position
    slots[activeWordPosIndex].sprite  = activeSprite;
    slots[activeWordPosIndex].correct = true;

    // 7) For the other 3 positions, we pick random distinct sprites from colourPool
    //    that are NOT the activeSprite (to avoid duplication).
    var usedSprites = ds_list_create();
    ds_list_add(usedSprites, activeSprite); // we won't reuse it

    // We'll fill the leftover 3 positions in a random order
    var availablePositions = [];
    for (var j = 0; j < 4; j++) {
        if (j != activeWordPosIndex) {
            array_push(availablePositions, j);
        }
    }

    // 8) For each leftover position, pick a random sprite from colourPool (excluding active)
    for (var p = 0; p < array_length_1d(availablePositions); p++) {
        var posIndex = availablePositions[p];

        // pick a random sprite from colourPool that we haven't used
        // We'll keep picking until we find one not in usedSprites
        var chosen = -1;
        repeat(999) { // safety loop
            var rnd = irandom_range(0, array_length_1d(colourPool)-1);
            var candidate = colourPool[rnd];
            if (ds_list_find_index(usedSprites, candidate) == -1) {
                chosen = candidate;
                ds_list_add(usedSprites, candidate);
                break;
            }
        }
        slots[posIndex].sprite  = chosen;
        slots[posIndex].correct = false;
    }

    ds_list_destroy(usedSprites);
    
    show_debug_message("oColourController: RefreshPositions for word '"
        + currentWord + "' => activeSprite at slot " 
        + string(activeWordPosIndex));
}



// Setup the first 4 slots
RefreshPositions();
