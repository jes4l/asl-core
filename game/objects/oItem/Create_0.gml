var pathSpeed = 0; // Stationary initially
path_start(ShoppingGamePath, pathSpeed, path_action_stop, true);
show_debug_message("Food item created at position: " + string(path_position) + " with ID: " + string(id));
alarm[0] = room_speed * 10; // Set alarm to move the object after 10 seconds