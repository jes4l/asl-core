/// scrUpdateWordList(_gameName, _numOfActiveWords)
/// @description Sets global.activeWords to a specified number of random words from the game’s pool
/// @param _gameName The name of the game to determine the word pool
/// @param _numOfActiveWords The number of active words to select

function scrUpdateWordList(_gameName, _numOfActiveWords) {
    var pizzaPool    = [ "Police", "Doctor", "Fireman", "Scientist", "Cowboy", "Chef" ];
    var placesPool   = [ "Police", "Doctor", "Fireman", "Scientist", "Cowboy", "Chef" ];
    var rolePool     = [ "Police", "Doctor", "Fireman", "Scientist", "Cowboy", "Chef" ];
    var shoppingPool = [ "Police", "Doctor", "Fireman", "Scientist", "Cowboy", "Chef" ];
    var colourPool   = [ "Police", "Doctor", "Fireman", "Scientist", "Cowboy", "Chef" ];

    var wordPool;
    switch (_gameName) {
        case "Pizza Game":
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

    var selectedWords = [];
    var usedIndices = ds_list_create();

    var maxWords = min(_numOfActiveWords, array_length_1d(wordPool));

    while (array_length_1d(selectedWords) < maxWords) {
        if (array_length_1d(wordPool) <= maxWords) {
            selectedWords = wordPool;
            break;
        }
        
        var r = irandom_range(0, array_length_1d(wordPool) - 1);
        if (ds_list_find_index(usedIndices, r) == -1) {
            ds_list_add(usedIndices, r);
            array_push(selectedWords, wordPool[r]);
        }
    }
    
    ds_list_destroy(usedIndices);
    global.activeWords = selectedWords;
}
