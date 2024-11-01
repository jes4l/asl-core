// Create Event of oLetterController

global.msg = "";

// Create an array to map each message to its corresponding letter object
letter_map = array_create(5);
letter_map[0] = oA;
letter_map[1] = oB;
letter_map[2] = oC;
letter_map[3] = oD;
letter_map[4] = oE;

// A variable to store the previously displayed instance
previous_instance = noone;
