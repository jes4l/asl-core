/// @description Handles Server Connection & Parses Hand Data

var n_id = ds_map_find_value(async_load, "id");
if(n_id == server_socket)
{
    var t = ds_map_find_value(async_load, "type");
    var socketlist = ds_list_create();

    if(t == network_type_connect)
    {
        var sock = ds_map_find_value(async_load, "socket");
        ds_list_add(socketlist, sock);
    }

    if(t == network_type_data)
    {
        var t_buffer = ds_map_find_value(async_load, "buffer"); 
        var cmd_type = buffer_read(t_buffer, buffer_string);

        // Original string
        originalString = string(cmd_type);

        try
        {
            jsonData = json_parse(originalString);

            if variable_struct_exists(jsonData, "data")
            {
                var currentLetter = jsonData.data;

                // Check if the letter has changed
                if (!variable_global_exists("lastLetter") || currentLetter != global.lastLetter)
                {
                    global.lastLetter = currentLetter; // Update last letter
                    global.msg = currentLetter;        // Update global.msg with the new letter
                    show_debug_message("Letter changed: " + global.msg);
                }

                global.letterReceived = currentLetter; // Always update the received letters
            }
        }
        catch(e)
        {
        }

        try
        {
            jsonData = json_parse(originalString);

            if variable_struct_exists(jsonData, "pos")
            {
                // Check if the array has at least two elements (x and y)
                if (is_array(jsonData.pos) && array_length(jsonData.pos) >= 2)
                {
                    var x_pos = jsonData.pos[0]; // First element is x position
                    var y_pos = jsonData.pos[1]; // Second element is y position

                    show_debug_message("Received position from Python: x = " + string(x_pos) + ", y = " + string(y_pos));
                    global.hand_x = x_pos;
                    global.hand_y = y_pos;
                }
            }
        }
    }
}
