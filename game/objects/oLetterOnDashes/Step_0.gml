// oLetterOnDashes - Step Event

// 1. Fade out the wrong letter if any
if (wrongLetter != "") {
    wrongLetterAlpha -= 0.02; // fade speed
    if (wrongLetterAlpha <= 0) {
        wrongLetter      = "";
        wrongLetterAlpha = 0;
    }
}

// 2. If all words are completed, do nothing
if (wordIndex >= wordsTotal) {
    return;
}

// 3. Check if the current word is completed
if (currentIndex >= letterCount) {
    // Word complete
    if (letters != undefined && letterCount > 0) {
        show_debug_message("Word Complete: " + ds_list_find_value(wordsDS, wordIndex));
        statusMessage = "Word Complete!";
        statusTimer = 180; // 3 seconds at 60 FPS
    }

    wordsCompleted++;
    wordIndex++;

    if (wordIndex >= wordsTotal) {
        // All words done
        show_debug_message("List Complete!");
        statusMessage = "List Complete!";
        statusTimer = 180; // 3 seconds
        return;
    } else {
        // Load next word
        LoadWord(wordIndex);
    }

    return; // skip the rest of this step
}

// 4. Check user’s guess (global.letter)
if (global.letter != "") {
    var neededChar = (letterCount > 0) ? letters[currentIndex] : "";

    // Find consecutive duplicates of neededChar
    var tempIndex = currentIndex + 1;
    while (tempIndex < letterCount && letters[tempIndex] == neededChar) {
        tempIndex++;
    }

    // Correct guess?
    if (global.letter == neededChar) {
        // Mark all repeated letters in green
        for (var i = currentIndex; i < tempIndex; i++) {
            letterColor[i] = c_green;
            letterAlpha[i] = 1.0;
        }
        // Advance currentIndex past all those letters
        currentIndex = tempIndex;

    // Wrong guess?
    } else {
        // Show the *guessed* letter in red
        wrongLetter      = global.letter;
        wrongLetterAlpha = 0.8;
        // Place it at the dash of the letter we still need
        wrongLetterX     = xPositions[currentIndex];
        wrongLetterY     = yPositions[currentIndex];
        // We do NOT increment currentIndex, user must guess again
    }

    // Clear the guess
    global.letter = "";
}

// 5. Handle status message timer
if (statusTimer > 0) {
    statusTimer -= 1;
    if (statusTimer <= 0) {
        statusMessage = "";
        statusTimer = 0;
    }
}
