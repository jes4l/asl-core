// Clamp clock time so it never goes below 0
if (instance_exists(oClock) && oClock.timeLeft < 0) {
    oClock.timeLeft = 0;
}

// 1. Handle next word delay
if (nextWordDelay > 0) {
    nextWordDelay--;
    // Ensure nextWordDelay never goes negative
    if (nextWordDelay <= 0) {
        nextWordDelay = 0;
        // Always load the next word after the delay is up, if available
        if (wordIndex < wordsTotal) {
            LoadWord(wordIndex);
        }
    }
    return;
}

// 2. Fade out the wrong letter if any
if (wrongLetter != "") {
    wrongLetterAlpha -= 0.02; // fade speed
    if (wrongLetterAlpha <= 0) {
        wrongLetter      = "";
        wrongLetterAlpha = 0;
    }
}

// 3. Check if all words are completed
if (wordIndex >= wordsTotal) {
    if (instance_exists(oClock)) {
        oClock.timeLeft = 0;
        oClock.drawTimer = false;
    }
    
    // Clear status and letter data
    statusMessage = "";
    statusTimer   = 0;
    drawOLetterOnDashes = false;
    letters = [];
    letterCount = 0;
    
    global.gameComplete = true;
    
    return;
}

// 4. If the clock is 0, end the current word
if (instance_exists(oClock) && oClock.timeLeft <= 0) {
    if (currentIndex < letterCount) {
        for (var z = currentIndex; z < letterCount; z++) {
            letterColor[z] = c_red;
            letterAlpha[z] = 1.0;
        }

        if (wordIndex < wordsTotal) {
            var finishedWord = ds_list_find_value(wordsDS, wordIndex);
            show_debug_message("Time ran out for word: " + finishedWord);
        }

        statusMessage = "Time Is Up!";
        statusTimer   = 30;

        wordsCompleted++;
        wordIndex++;

        nextWordDelay = room_speed * 0.5;
        return;
    }
}

// 5. Check if the current word is completed
if (currentIndex >= letterCount) {
    if (letters != undefined && letterCount > 0 && wordIndex < wordsTotal) {
        var doneWord = ds_list_find_value(wordsDS, wordIndex);
        show_debug_message("Word Complete: " + doneWord);
        statusMessage = "Word Complete!";
        statusTimer   = 30;
    }

    wordsCompleted++;
    wordIndex++;

    if (wordIndex >= wordsTotal) {
        show_debug_message("List Complete!");
        
        statusMessage = "";
        statusTimer   = 0;

        if (instance_exists(oClock)) {
            oClock.timeLeft = 0;
            oClock.drawTimer = false;
        }
        
        drawOLetterOnDashes = false;
        letters = [];
        letterCount = 0;
        global.gameComplete = true;
        return;
    } else {
        nextWordDelay = room_speed * 0.5;
        return;
    }
}

// 6. Check user’s guess (global.letter)
if (global.letter != "") {
    var neededChar = (letterCount > 0) ? letters[currentIndex] : "";

    if (string_lower(global.letter) == string_lower(neededChar)) {
        if (letterWasWrong[currentIndex]) {
            letterColor[currentIndex] = c_orange;
			global.score += 1
			global.scoreGained +=1;
        } else {
            letterColor[currentIndex] = c_green;
			global.score += 2;
			global.scoreGained += 2;
        }
        letterAlpha[currentIndex] = 1.0;
        currentIndex++;

        // If the letter was previously wrong and now correct, record it
        if (letterWasWrong[currentIndex - 1]) {
            var correctedLetter = string_lower(global.letter);
            ds_list_add(global.wasWrongLetters, correctedLetter);
            letterWasWrong[currentIndex - 1] = false;
        }
    } else {
        var wrongChar = string_lower(global.letter);
        ds_list_add(global.wrongLetters, wrongChar); // Add to wrongLetters

        wrongLetter      = wrongChar;
        wrongLetterAlpha = 0.8;
        letterWasWrong[currentIndex] = true;
        wrongLetterX     = xPositions[currentIndex];
        wrongLetterY     = yPositions[currentIndex];

        if (instance_exists(oClock)) {
            with (oClock) {
                timeLeft += 3;
                if (timeLeft > 0) {
                    alarm[0] = room_speed;
                }
            }
        }
    }

    global.letter = "";
}

// 7. Handle status message timer
if (statusTimer > 0) {
    statusTimer--;
    if (statusTimer <= 0) {
        statusMessage = "";
    }
}

// 8. (Optional) Debug Logging for Tracking Lists
var wrongLettersDebug = "Wrong Letters: ";
if (ds_exists(global.wrongLetters, ds_type_list)) {
    for (var i = 0; i < ds_list_size(global.wrongLetters); i++) {
        wrongLettersDebug += ds_list_find_value(global.wrongLetters, i) + " ";
    }
} else {
    wrongLettersDebug += "None";
}

var wasWrongLettersDebug = "Was Wrong Letters: ";
if (ds_exists(global.wasWrongLetters, ds_type_list)) {
    for (var i = 0; i < ds_list_size(global.wasWrongLetters); i++) {
        wasWrongLettersDebug += ds_list_find_value(global.wasWrongLetters, i) + " ";
    }
} else {
    wasWrongLettersDebug += "None";
}

// show_debug_message("Debugging Tracking Lists:\n" + wrongLettersDebug + "\n" + wasWrongLettersDebug);
