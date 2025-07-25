function getAverageConfidence(letter) {
    var sum = 0;
    var count = 0;
    if (ds_exists(global.confidenceLetters, ds_type_list)) {
        for (var i = 0; i < ds_list_size(global.confidenceLetters); i++) {
            var pair = ds_list_find_value(global.confidenceLetters, i);
            if (string_upper(pair[0]) == letter) {
                sum += pair[1];
                count++;
            }
        }
    }
    if (count == 0) return 0;
    return sum / count;
}

function scrUpdateWordList(_gameName, _numOfActiveWords) {
    var pizzaPool    = [ "Tomato", "Pineapple", "Mushroom", "Sweetcorn", "Pepperoni", "Bacon" ];
    var placesPool   = [ "Library", "Cinema", "Hospital", "Park", "Museum", "School" ];
    var rolePool     = [ "Police", "Firefighter", "Scientist", "Cowboy", "Cowgirl", "Chef" ];
    var shoppingPool = [ "Apple", "Orange", "Grape", "Pear", "Strawberry", "Carrot", "Watermelon" ];
    var colourPool   = [ "Blue", "Brown", "Green", "Oranges", "Pink", "Purple", "Red", "White", "Yellow" ];
    
    var wordPool;
    switch (_gameName) {
        case "Ingredients Game":
            wordPool = pizzaPool; 
            break;
        case "Places Game":
            wordPool = placesPool;
            break;
        case "Role Game":
            wordPool = rolePool;
            break;
        case "Shopping Game":
            wordPool = shoppingPool;
            break;
        case "Colours Game":
            wordPool = colourPool;
            break;
        default:
            wordPool = [ "invalid", "game", "name" ];
            break;
    }
    
    if (array_length_1d(wordPool) <= _numOfActiveWords) {
        global.activeWords = wordPool;
        if (ds_exists(global.wrongLetters, ds_type_list)) ds_list_clear(global.wrongLetters);
        if (ds_exists(global.wasWrongLetters, ds_type_list)) ds_list_clear(global.wasWrongLetters);
        return;
    }
    
    var baseline       = 0.5; 
    var wrongWeight    = 0.75; 
    var wasWrongWeight = 1;
    
    var weightedWords = [];
    for (var i = 0; i < array_length_1d(wordPool); i++) {
        var word = wordPool[i];
        var totalLetterWeight = 0;
        var len = string_length(word);
        for (var j = 1; j <= len; j++) {
            var letter = string_upper(string_copy(word, j, 1));
            var baseLetterWeight = baseline;
            if (ds_exists(global.wrongLetters, ds_type_list) && ds_list_find_index(global.wrongLetters, letter) != -1) {
                baseLetterWeight = wrongWeight;
            } else if (ds_exists(global.wasWrongLetters, ds_type_list) && ds_list_find_index(global.wasWrongLetters, letter) != -1) {
                baseLetterWeight = wasWrongWeight;
            }
            if (ds_exists(global.correctLetters, ds_type_list) && ds_list_find_index(global.correctLetters, letter) != -1) {
                baseLetterWeight = baseLetterWeight - 0.25;
                if (baseLetterWeight < 0.5) baseLetterWeight = 0.5;
            }
            var avgConfidence = getAverageConfidence(letter);
            var letterFinalWeight = baseLetterWeight * (1 - avgConfidence);
            totalLetterWeight += letterFinalWeight;
        }
        var wordScoreNormalized = totalLetterWeight / len;
        weightedWords[i] = { word: word, weight: wordScoreNormalized };
    }
    
    var selectedWords = [];
    var tempWeightedWords = weightedWords;
    
    while (array_length_1d(tempWeightedWords) > 0 && array_length_1d(selectedWords) < _numOfActiveWords) {
        var totalWeight = 0;
        for (var i = 0; i < array_length_1d(tempWeightedWords); i++) {
            totalWeight += tempWeightedWords[i].weight;
        }
        var r = random(totalWeight);
        var cumulative = 0;
        var selectedIndex = 0;
        for (var i = 0; i < array_length_1d(tempWeightedWords); i++) {
            cumulative += tempWeightedWords[i].weight;
            if (r < cumulative) {
                selectedIndex = i;
                break;
            }
        }
        selectedWords[array_length_1d(selectedWords)] = tempWeightedWords[selectedIndex].word;
        array_delete(tempWeightedWords, selectedIndex, 1);
    }
    
    global.activeWords = selectedWords;
    
    var wrongLettersDebug = "Wrong Letters - Letter That You Inputted Wrong: ";
    if (ds_exists(global.wrongLetters, ds_type_list)) {
        for (var i = 0; i < ds_list_size(global.wrongLetters); i++) {
            wrongLettersDebug += ds_list_find_value(global.wrongLetters, i) + " ";
        }
    } else {
        wrongLettersDebug += "None";
    }
    show_debug_message(wrongLettersDebug);
    
    var wasWrongLettersDebug = "Was Wrong Letters - Letter in Word That You Got Wrong: ";
    if (ds_exists(global.wasWrongLetters, ds_type_list)) {
        for (var i = 0; i < ds_list_size(global.wasWrongLetters); i++) {
            wasWrongLettersDebug += ds_list_find_value(global.wasWrongLetters, i) + " ";
        }
    } else {
        wasWrongLettersDebug += "None";
    }
    show_debug_message(wasWrongLettersDebug);
    
    var correctLettersDebug = "Correct Letters - Letters That You Got Correct: ";
    if (ds_exists(global.correctLetters, ds_type_list)) {
        for (var i = 0; i < ds_list_size(global.correctLetters); i++) {
            correctLettersDebug += ds_list_find_value(global.correctLetters, i) + " ";
        }
    } else {
        correctLettersDebug += "None";
    }
    show_debug_message(correctLettersDebug);
    
    var alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    var letterWeightsDebug = "Letter Weights: ";
    for (var i = 1; i <= string_length(alphabet); i++) {
        var letter = string_upper(string_copy(alphabet, i, 1));
        var baseLetterWeight = baseline;
        if (ds_exists(global.wrongLetters, ds_type_list) && ds_list_find_index(global.wrongLetters, letter) != -1) {
            baseLetterWeight = wrongWeight;
        } else if (ds_exists(global.wasWrongLetters, ds_type_list) && ds_list_find_index(global.wasWrongLetters, letter) != -1) {
            baseLetterWeight = wasWrongWeight;
        }
        if (ds_exists(global.correctLetters, ds_type_list) && ds_list_find_index(global.correctLetters, letter) != -1) {
            baseLetterWeight = baseLetterWeight - 0.25;
            if (baseLetterWeight < 0.5) baseLetterWeight = 0.5;
        }
        letterWeightsDebug += letter + ": " + string(baseLetterWeight) + " ";
    }
    show_debug_message(letterWeightsDebug);
}
