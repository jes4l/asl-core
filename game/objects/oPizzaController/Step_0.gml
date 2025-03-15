if (letterController != noone) {
    if (ds_exists(letterController.wordsDS, ds_type_list)) {
        var currentWord = "";
        if (letterController.wordIndex < ds_list_size(letterController.wordsDS)) {
            currentWord = ds_list_find_value(letterController.wordsDS, letterController.wordIndex);
            currentWord = string_lower(currentWord);
        }
        if (letterController.wordIndex >= ds_list_size(letterController.wordsDS)) {
            currentWord = "";
        }
        var storeSprite = true;
        if (previousWord != "") {
            storeSprite = true;
            for (var k = 0; k < ds_list_size(global.incorrectWords); k++) {
                var inc = global.incorrectWords[| k];
                if (string_lower(inc) == string_lower(previousWord)) {
                    storeSprite = false;
                    break;
                }
            }
        }
        if (currentWord == "" && previousWord != "") {
            if (storeSprite) {
                scrGetWordPoolSprite(previousWord);
                var lastSprite = sprite_index;
                var instances = [];
                for (var j = 0; j < 10; j++) {
                    var rotation = irandom_range(0, 360);
                    if (pizzaBase != noone) {
                        var effectiveRadius = min(sprite_get_width(pizzaBase.sprite_index), sprite_get_height(pizzaBase.sprite_index)) / 2;
                        var angle = random_range(0, 360);
                        var distance = sqrt(random(1)) * effectiveRadius;
                        var offsetX = distance * cos(angle);
                        var offsetY = distance * sin(angle);
                        array_push(instances, { offsetX: offsetX, offsetY: offsetY, rotation: rotation });
                    } else {
                        var posX = irandom_range(977, 1340);
                        var posY = irandom_range(700, 900);
                        array_push(instances, { x: posX, y: posY, rotation: rotation });
                    }
                }
                var lastWordMap = ds_map_create();
                ds_map_add(lastWordMap, "word", previousWord);
                ds_map_add(lastWordMap, "sprite", lastSprite);
                ds_map_add(lastWordMap, "instances", instances);
                ds_list_add(global.pizzaItems, lastWordMap);
                show_debug_message("Stored sprite for final word: " + previousWord);
            }
            previousWord = "";
        }
        if (currentWord != previousWord && currentWord != "") {
            if (previousWord != "") {
                storeSprite = true;
                for (var k = 0; k < ds_list_size(global.incorrectWords); k++) {
                    var inc = global.incorrectWords[| k];
                    if (string_lower(inc) == string_lower(previousWord)) {
                        storeSprite = false;
                        break;
                    }
                }
                if (storeSprite) {
                    scrGetWordPoolSprite(previousWord);
                    var prevSprite = sprite_index;
                    var instances = [];
                    for (var j = 0; j < 10; j++) {
                        var rotation = irandom_range(0, 360);
                        if (pizzaBase != noone) {
                            var effectiveRadius = min(sprite_get_width(pizzaBase.sprite_index), sprite_get_height(pizzaBase.sprite_index)) / 2;
                            var angle = random_range(0, 360);
                            var distance = sqrt(random(1)) * effectiveRadius;
                            var offsetX = distance * cos(angle);
                            var offsetY = distance * sin(angle);
                            array_push(instances, { offsetX: offsetX, offsetY: offsetY, rotation: rotation });
                        } else {
                            var posX = irandom_range(977, 1340);
                            var posY = irandom_range(700, 900);
                            array_push(instances, { x: posX, y: posY, rotation: rotation });
                        }
                    }
                    var wordSpriteMap = ds_map_create();
                    ds_map_add(wordSpriteMap, "word", previousWord);
                    ds_map_add(wordSpriteMap, "sprite", prevSprite);
                    ds_map_add(wordSpriteMap, "instances", instances);
                    ds_list_add(global.pizzaItems, wordSpriteMap);
                    show_debug_message("Stored sprite for previous word: " + previousWord);
                }
            }
            previousWord = currentWord;
        }
    } else {
        show_debug_message("wordsDS does not exist or is not a ds_list.");
    }
} else {
    show_debug_message("letterController is noone.");
}
if (global.gameComplete) {
    if (letterController != noone) {
        letterController.statusMessage = "Cooking";
    }
    if (pizzaBase != noone) {
        if (!pizzaBasePathStarted) {
            with (pizzaBase) {
                path_start(pathPizzaGameEnd, 4, path_action_stop, false);
            }
            pizzaBasePathStarted = true;
        } else {
            if (pizzaBase.path_index == -1) {
                global.gameComplete = false;
                room_goto(rmPizzaGameEnd);
            }
        }
    }
}
