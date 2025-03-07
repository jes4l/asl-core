colourPool = [ sBlue, sBrown, sGreen, sOranges, sPink, sPurple, sRed, sWhite, sYellow ];
positions = [
    { x: 920, y: 500 },
    { x: 1075, y: 500 },
    { x: 1230, y: 500 },
    { x: 1385, y: 500 }
];
wordIndex = 0;
slots = [];
feedbackMessage = "";
feedbackTimer = 0;
global.gameComplete = false;
mixingTimer = 0;
global.finalSegments = [ -1, -1, -1, -1 ];
global.finalSegmentCount = 0;

function RefreshPositions()
{
    if (wordIndex >= array_length_1d(global.activeWords)) {
        slots = [
            { sprite: -1, x: positions[0].x, y: positions[0].y, correct: false },
            { sprite: -1, x: positions[1].x, y: positions[1].y, correct: false },
            { sprite: -1, x: positions[2].x, y: positions[2].y, correct: false },
            { sprite: -1, x: positions[3].x, y: positions[3].y, correct: false }
        ];
        return;
    }
    var currentWord = global.activeWords[wordIndex];
    var activeSprite = scrGetWordPoolSprite(currentWord, false);
    var activeWordPosIndex = irandom_range(0, 3);
    slots = [];
    for (var i = 0; i < 4; i++) {
        slots[i] = {
            sprite: -1,
            x: positions[i].x,
            y: positions[i].y,
            correct: false
        };
    }
    slots[activeWordPosIndex].sprite = activeSprite;
    slots[activeWordPosIndex].correct = true;
    var usedSprites = ds_list_create();
    ds_list_add(usedSprites, activeSprite);
    var availablePositions = [];
    for (var j = 0; j < 4; j++) {
        if (j != activeWordPosIndex) {
            array_push(availablePositions, j);
        }
    }
    for (var p = 0; p < array_length_1d(availablePositions); p++) {
        var posIndex = availablePositions[p];
        var chosen = -1;
        repeat(999) {
            var rnd = irandom_range(0, array_length_1d(colourPool) - 1);
            var candidate = colourPool[rnd];
            if (ds_list_find_index(usedSprites, candidate) == -1) {
                chosen = candidate;
                ds_list_add(usedSprites, candidate);
                break;
            }
        }
        slots[posIndex].sprite = chosen;
        slots[posIndex].correct = false;
    }
    ds_list_destroy(usedSprites);
    show_debug_message("oColourController: Word='" + currentWord + "' => correct sprite at slot " + string(activeWordPosIndex));
}

RefreshPositions();