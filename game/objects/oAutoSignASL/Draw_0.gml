// Timer variable to track elapsed time
if (!variable_instance_exists(id, "elapsedTime")) {
    elapsedTime = 0;
}
if (!variable_instance_exists(id, "currentWord")) {
    currentWord = global.targetWord;
}
var displayInterval = 2; // Display interval in seconds
var disappearInterval = 0.5; // Disappear interval in seconds

// Function to draw centered text
function drawCenteredText(x, y, text, font) {
    var originalFont = draw_get_font();
    draw_set_font(font);
    var textWidth = string_width(text);
    var textHeight = string_height(text);
    var displayX = x - (textWidth / 2);
    var displayY = y - (textHeight / 2);
    draw_text(displayX, displayY, text);
    draw_set_font(originalFont);
}

// Function to draw centered sprite
function drawCenteredSprite(x, y, sprite) {
    var spriteWidth = sprite_get_width(sprite);
    var spriteHeight = sprite_get_height(sprite);
    var displayX = x - (spriteWidth / 2);
    var displayY = y - (spriteHeight / 2);
    draw_sprite(sprite, 0, displayX, displayY);
}

// Set drawing color to black
draw_set_color(c_black);

// Draw the sign text
var signText = "Sign";
var signFont = fnt_letter_smallest;
var signX = x + (bbox_right - bbox_left) / 2;
var signY = y + (bbox_bottom - bbox_top) * 0.1;
drawCenteredText(signX, signY, signText, signFont);

// Function to get ASL sign sprite
function getASLSignSprite(letter) {
    var aslSignName = "s" + string_upper(letter); // Look for a sprite like sA, sB, etc.
    var aslSignSprite = asset_get_index(aslSignName);
    return (aslSignSprite != -1) ? aslSignSprite : -1; // Return sprite index or -1 if not found
}

// Check if the target word has changed
if (currentWord != global.targetWord) {
    currentWord = global.targetWord;
    elapsedTime = 0; // Reset the timer
}

// Calculate the current letter index based on elapsed time
var totalInterval = displayInterval + disappearInterval;
var currentIndex = floor(elapsedTime / totalInterval);

// Only draw if the current index is within the word length
if (currentIndex < string_length(currentWord)) {
    // Determine if we are in the display or disappear phase
    var phase = elapsedTime % totalInterval;

    if (phase < displayInterval) {
        var nextLetter = string_char_at(currentWord, currentIndex + 1);
        var aslSignSprite = getASLSignSprite(nextLetter);

        // Draw the ASL sign sprite if it exists
        if (aslSignSprite != -1) {
            var letterX = x + (bbox_right - bbox_left) / 2;
            var letterY = y + (bbox_bottom - bbox_top) / 2;
            drawCenteredSprite(letterX, letterY, aslSignSprite);
        }
    }
}

// Update the elapsed time
elapsedTime += delta_time / 1000000; // Convert microseconds to seconds

// Reset drawing color to default
draw_set_color(-1);