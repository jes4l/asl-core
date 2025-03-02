if (!variable_instance_exists(self, "wordsList") || !ds_list_exists(wordsList)) {
    wordsList = ds_list_create();
}

if (is_array(global.activeWords) && array_length_1d(global.activeWords) > 0) {
    for (var i = 0; i < array_length_1d(global.activeWords); i++) {
        ds_list_add(wordsList, global.activeWords[i]);
    }
} else {
    ds_list_add(wordsList, "no words found!");
}

show_debug_message("Active Words: " + string(global.activeWords));
