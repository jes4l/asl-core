wordsList = ds_list_create();
if (global.activeWords != undefined) {
    for (var i = 0; i < array_length(global.activeWords); i++) {
        ds_list_add(wordsList, global.activeWords[i]);
    }
} else {
    ds_list_add(wordsList, "no words found!");
}
show_debug_message(global.activeWords);