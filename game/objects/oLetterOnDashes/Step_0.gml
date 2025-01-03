

//////////////////////
// STEP EVENT
//////////////////////

/// 1) Fade out any wrong letter overlay
if (wrongLetter != "") {
    wrongLetterAlpha -= 0.02; // fade speed
    if (wrongLetterAlpha <= 0) {
        wrongLetter      = "";
        wrongLetterAlpha = 0;
    }
}

/// 2) If all words are completed, do nothing further
if (wordIndex >= wordsTotal) {
    return;
}

/// 3) Check if the current word is already fully completed
if (currentIndex >= letterCount) {
    // Word complete
    if (letters != undefined && letterCount > 0) {
        show_debug_message("Word Complete: " + ds_list_find_value(wordsDS, wordIndex));
        statusMessage = "Word Complete!";
        statusTimer   = 180; // ~3 seconds at 60 FPS
    }
    
    wordsCompleted++;
    wordIndex++;
    
    // All words done?
    if (wordIndex >= wordsTotal) {
        show_debug_message("List Complete!");
        statusMessage = "List Complete!";
        statusTimer   = 180;
        return;
    } else {
        // Load the next word
        LoadWord(wordIndex);
    }
    return; // skip the rest for this step
}

/// 4) Compare the user’s guess (global.letter) with the needed letter
if (global.letter != "") {
    var neededChar = (letterCount > 0) ? letters[currentIndex] : "";
    
    // Find consecutive duplicates of neededChar (e.g., if the word has "aa")
    var tempIndex = currentIndex + 1;
    while (tempIndex < letterCount && letters[tempIndex] == neededChar) {
        tempIndex++;
    }
    
    // --- Correct Guess ---
    if (global.letter == neededChar) {
        // Mark all repeated letters in the segment [currentIndex .. tempIndex-1]
        for (var i = currentIndex; i < tempIndex; i++) {
            // If letter was guessed wrong at least once, color it ORANGE
            if (letterWasWrong[i]) {
                letterColor[i] = make_color_rgb(255, 165, 0); // Orange
            } else {
                letterColor[i] = c_green;
            }
            letterAlpha[i] = 1.0;
        }
        // Advance the index beyond these duplicates
        currentIndex = tempIndex;
    }
    // --- Wrong Guess ---
    else {
        wrongLetter      = global.letter;
        wrongLetterAlpha = 0.8;
        
        // Mark that this letter index had a wrong attempt
        letterWasWrong[currentIndex] = true;
        
        // Place the red “wrong guess” overlay
        wrongLetterX = xPositions[currentIndex];
        wrongLetterY = yPositions[currentIndex];
        // currentIndex NOT incremented for a wrong guess
    }
    
    // Clear the guess so we don't process it repeatedly
    global.letter = "";
}

/// 5) Handle status message timers
if (statusTimer > 0) {
    statusTimer--;
    if (statusTimer <= 0) {
        statusMessage = "";
        statusTimer   = 0;
    }
}

