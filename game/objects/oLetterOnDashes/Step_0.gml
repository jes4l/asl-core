/// oLetterOnDashes - Step Event

// 1. Handle next word delay
if (nextWordDelay > 0) {
    nextWordDelay--;
    if (nextWordDelay <= 0) {
        // After delay, move to the next word
        if (wordIndex < wordsTotal) {
            LoadWord(wordIndex);
        }
    }
    return; // Skip further processing during the delay
}

// 2. Fade out the wrong letter if any
if (wrongLetter != "") {
    wrongLetterAlpha -= 0.02; // fade speed
    if (wrongLetterAlpha <= 0) {
        wrongLetter      = "";
        wrongLetterAlpha = 0;
    }
}

// 3. If all words are completed, do nothing
if (wordIndex >= wordsTotal) {
    if (instance_exists(oClock)) {
        oClock.timeLeft = 0;
    }
    if (room == rmPizzaGame) {
        room_goto(rmPizzaGameOven);
    }
    return;
}

// 4. If the clock is 0, end the current word
if (instance_exists(oClock) && oClock.timeLeft <= 0) {
    if (currentIndex < letterCount) {
        for (var z = currentIndex; z < letterCount; z++) {
            letterColor[z] = c_orange;
            letterAlpha[z] = 1.0;
        }

        if (wordIndex < wordsTotal) {
            var finishedWord = ds_list_find_value(wordsDS, wordIndex);
            show_debug_message("Time ran out for word: " + finishedWord);
        }

        statusMessage = "Time Is Up!";
        statusTimer   = 180;

        wordsCompleted++;
        wordIndex++;

        // Introduce a delay before loading the next word
        nextWordDelay = room_speed; // 1 second delay
        return; // Stop further processing for this step
    }
}

// 5. Check if the current word is completed
if (currentIndex >= letterCount) {
    if (letters != undefined && letterCount > 0 && wordIndex < wordsTotal) {
        var doneWord = ds_list_find_value(wordsDS, wordIndex);
        show_debug_message("Word Complete: " + doneWord);
        statusMessage = "Word Complete!";
        statusTimer   = 180;
    }

    wordsCompleted++;
    wordIndex++;

    if (wordIndex >= wordsTotal) {
        show_debug_message("List Complete!");
        statusMessage = "List Complete!";
        statusTimer   = 180;

        if (instance_exists(oClock)) {
            oClock.timeLeft = 0;
        }
        return;
    } else {
        // Introduce a delay before loading the next word
        nextWordDelay = room_speed; // 1 second delay
        return; // Stop further processing for this step
    }
}

// 6. Check user’s guess (global.letter)
if (global.letter != "") {
    var neededChar = (letterCount > 0) ? letters[currentIndex] : "";

    if (string_lower(global.letter) == string_lower(neededChar)) {
        if (letterWasWrong[currentIndex]) {
            letterColor[currentIndex] = c_orange;
        } else {
            letterColor[currentIndex] = c_green;
        }
        letterAlpha[currentIndex] = 1.0;
        currentIndex++;

        // **If the letter was previously wrong and now correct, move it to wasWrongLetters**
        if (letterWasWrong[currentIndex - 1]) {
            var correctedLetter = string_lower(global.letter);
            ds_list_add(global.wasWrongLetters, correctedLetter);
            letterWasWrong[currentIndex - 1] = false; // Reset the wrong flag
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

// 8. Debug Message for Tracking Lists
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


//show_debug_message("Debugging Tracking Lists:\n" + 
  //  wrongLettersDebug + "\n" + 
    //wasWrongLettersDebug);
