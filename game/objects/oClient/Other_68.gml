/// @description Handles Server Connection & Parses Hand Data

var n_id = ds_map_find_value(async_load, "id");

// Ensure the event is for the correct socket
if (n_id == server_socket) {
    var t = ds_map_find_value(async_load, "type");

    // Handle new connection
    if (t == network_type_connect) {
        var sock = ds_map_find_value(async_load, "socket");
        var socketlist = ds_list_create();
        ds_list_add(socketlist, sock);
    }

    // Handle incoming data
    if (t == network_type_data) {
        var t_buffer = ds_map_find_value(async_load, "buffer"); 
        var originalString = buffer_read(t_buffer, buffer_string);

        try {
            var jsonData = json_parse(originalString);

            // Handle letter data
            if (variable_struct_exists(jsonData, "data")) {
                var currentLetter = jsonData.data;

                var currentTime = current_time;

                // If the letter has changed
                if (!variable_global_exists("lastLetter") || currentLetter != global.lastLetter) {
                    global.lastLetter = currentLetter;
                    global.letter = currentLetter;
                    global.letterTimeStamp = currentTime; // Record the timestamp
                    show_debug_message("Letter: " + global.letter);
                } 
                // If the same letter persists beyond the debounce threshold
                else if (currentTime - global.letterTimeStamp >= 2000) { // 2000 ms = 2 seconds
                    global.lastLetter = ""; // Clear letter
                    global.letter = "";     // Allow re-registration
                    global.letterTimeStamp = currentTime; // Reset the timestamp
                    //show_debug_message("Letter reset after timeout.");
                }

                // Always update the received letters
                global.letterReceived = currentLetter;
            }

            // Handle position data
            if (variable_struct_exists(jsonData, "pos")) {
                if (is_array(jsonData.pos) && array_length(jsonData.pos) >= 2) {
                    global.xHand = jsonData.pos[0];
                    global.yHand = jsonData.pos[1];
                    show_debug_message("Received position: x = " + string(global.xHand) + ", y = " + string(global.yHand));
                }
            }
        } catch (e) {
            // Log parsing errors
            show_debug_message("Error parsing JSON: " + string(e));
        }
    }
}
