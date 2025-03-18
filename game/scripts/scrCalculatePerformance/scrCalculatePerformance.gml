/// @function scrCalculatePerformance()
/// @description Calculates and returns the top 3 best and worst performing letters,
///              only for letters found in the active word list.
/// @returns {struct} { best: array of letter objects, worst: array of letter objects }
function scrCalculatePerformance() {
    var activeLetterList = ds_list_create();
    for (var i = 0; i < array_length_1d(global.activeWords); i++) {
        var word = global.activeWords[i];
        for (var j = 1; j <= string_length(word); j++) {
            var letter = string_upper(string_copy(word, j, 1));
            if (ds_list_find_index(activeLetterList, letter) == -1) {
                ds_list_add(activeLetterList, letter);
            }
        }
    }
    
    var baseline       = 1;
    var wrongWeight    = 2;
    var wasWrongWeight = 3;
    var letterPerformances = [];
    
    for (var i = 0; i < ds_list_size(activeLetterList); i++) {
        var letter = ds_list_find_value(activeLetterList, i);
        var letterWeight = baseline;
        
        if (ds_exists(global.wrongLetters, ds_type_list) && ds_list_find_index(global.wrongLetters, letter) != -1) {
            letterWeight = wrongWeight;
        } else if (ds_exists(global.wasWrongLetters, ds_type_list) && ds_list_find_index(global.wasWrongLetters, letter) != -1) {
            letterWeight = wasWrongWeight;
        }
        if (ds_exists(global.correctLetters, ds_type_list) && ds_list_find_index(global.correctLetters, letter) != -1) {
            letterWeight -= 0.5;
            if (letterWeight < baseline) letterWeight = baseline;
        }
        
        letterPerformances[i] = { letter: letter, weight: letterWeight };
    }
    
    ds_list_destroy(activeLetterList);
    
    var sortedAscending = [];
    var sortedDescending = [];
    for (var i = 0; i < array_length_1d(letterPerformances); i++) {
        sortedAscending[i]  = letterPerformances[i];
        sortedDescending[i] = letterPerformances[i];
    }
    
    for (var i = 0; i < array_length_1d(sortedAscending) - 1; i++) {
        for (var j = i + 1; j < array_length_1d(sortedAscending); j++) {
            if (sortedAscending[i].weight > sortedAscending[j].weight) {
                var temp = sortedAscending[i];
                sortedAscending[i] = sortedAscending[j];
                sortedAscending[j] = temp;
            }
        }
    }
    
    for (var i = 0; i < array_length_1d(sortedDescending) - 1; i++) {
        for (var j = i + 1; j < array_length_1d(sortedDescending); j++) {
            if (sortedDescending[i].weight < sortedDescending[j].weight) {
                var temp = sortedDescending[i];
                sortedDescending[i] = sortedDescending[j];
                sortedDescending[j] = temp;
            }
        }
    }
    
    var bestLetters = [];
    var worstLetters = [];
    for (var i = 0; i < 3; i++) {
        if (i < array_length_1d(sortedAscending))
            bestLetters[i] = sortedAscending[i];
        if (i < array_length_1d(sortedDescending))
            worstLetters[i] = sortedDescending[i];
    }
    
    return { best: bestLetters, worst: worstLetters };
}
