var n_id = ds_map_find_value(async_load, "id");
if (n_id == server_socket) {
    var t = ds_map_find_value(async_load, "type");
    if (t == network_type_connect) {
        var sock = ds_map_find_value(async_load, "socket");
        var socketlist = ds_list_create();
        ds_list_add(socketlist, sock);
    }
    if (t == network_type_data) {
        var t_buffer = ds_map_find_value(async_load, "buffer");
        var receivedMessage = buffer_read(t_buffer, buffer_string);
        try {
            var jsonData = json_parse(receivedMessage);
            if (receivedMessage != global.lastReceivedMessage) {
                global.lastReceivedMessage = receivedMessage;
                global.lastMessageTime = current_time;
                global.connectionStatus = "Connected";
            }
            if (variable_struct_exists(jsonData, "data")) {
                var currentLetter = jsonData.data;
                var currentTime = current_time;
                if (!variable_global_exists("lastLetter") || currentLetter != global.lastLetter) {
                    global.lastLetter = currentLetter;
                    global.letter = currentLetter;
                    global.letterTimeStamp = currentTime;
                    show_debug_message("Letter: " + global.letter);
                } else if (currentTime - global.letterTimeStamp >= 2000) {
                    global.lastLetter = "";
                    global.letter = "";
                    global.letterTimeStamp = currentTime;
                }
                global.letterReceived = currentLetter;
                if (variable_struct_exists(jsonData, "confidence")) {
                    global.confidence = jsonData.confidence;
					show_debug_message("Letter: " + string(global.letter) + " Confidence: " + string(global.confidence));
                }
            }
            if (variable_struct_exists(jsonData, "pos")) {
                if (is_array(jsonData.pos) && array_length(jsonData.pos) >= 2) {
                    global.xHand = jsonData.pos[0];
                    global.yHand = jsonData.pos[1];
                    show_debug_message("Received position: x = " + string(global.xHand) + ", y = " + string(global.yHand));
                }
            }
        } catch (e) {
            show_debug_message("Error parsing JSON: " + string(e));
        }
    }
}