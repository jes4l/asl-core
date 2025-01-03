/// scrUpdateWordList(_gameName)
/// @description Sets global.activeWords to 3 random words from the game’s pool

function scrUpdateWordList(_gameName) {
    var pizzaPool    = [ "bab", "abca", "cab", "cba", "acb" ];
    var placesPool   = [ "paris", "london", "tokyo", "sydney", "berlin", "new york" ];
    var rolePool     = [ "teacher", "doctor", "engineer", "scientist", "pilot", "artist" ];
    var shoppingPool = [ "milk", "bread", "apples", "eggs", "juice", "cereal" ];
    var colourPool   = [ "red", "green", "blue", "yellow", "purple", "orange" ];

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

    while (array_length_1d(selectedWords) < 3) {
        if (array_length_1d(wordPool) <= 3) {
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
