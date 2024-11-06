global.msg = "";               // Current letter
global.previousLetters = "";   // Previously typed letters
global.customDashPositions = []; // Dash positions
global.letterList = [];        // Array to store letters sequentially
global.letterAlphas = [];      // Array to store alpha values for fading effect
global.dashWidth = 0;          // Dash width
global.dashHeight = 0;         // Dash height
global.targetWord = "";        // Target word
global.correctLetters = [];    // Array for correct letters

// Set initial alpha values for each letter
for (var i = 0; i < array_length_1d(global.letterList); i++) {
    array_push(global.letterAlphas, 1); // Fully opaque
}
