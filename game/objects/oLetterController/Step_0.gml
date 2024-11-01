// Step Event of the controller object

// Define the mapping based on the value of global.msg
var index = -1;

switch (global.msg) {
    case "al": index = 0; break;
    case "bl": index = 1; break;
    case "cl": index = 2; break;
    case "dl": index = 3; break;
    case "el": index = 4; break;
}

// Only proceed if there's a valid index
if (index != -1) {
    // Destroy the previous letter instance if it exists
    if (previous_instance != noone) instance_destroy(previous_instance);

    // Create the new letter instance and store it as the previous instance
    previous_instance = instance_create_layer(x, y, "Instances", letter_map[index]);
} else {
    // If global.msg is invalid, show the default setup object
    if (previous_instance != noone) instance_destroy(previous_instance);
    previous_instance = instance_create_layer(x, y, "Instances", oDefault);
}
