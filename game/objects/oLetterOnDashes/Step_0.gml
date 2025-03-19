if (instance_exists(oClock) && oClock.timeLeft < 0) {
    oClock.timeLeft = 0;
}
if (nextWordDelay > 0) {
    nextWordDelay--;
    if (nextWordDelay <= 0) {
        nextWordDelay = 0;
        if (wordIndex < wordsTotal) {
            scrLoadWord(wordIndex);
        }
    }
    return;
}
if (wrongLetter != "") {
    wrongLetterAlpha -= 0.02;
    if (wrongLetterAlpha <= 0) {
        wrongLetter = "";
        wrongLetterAlpha = 0;
    }
}
if (wordIndex >= wordsTotal) {
    if (instance_exists(oClock)) {
        oClock.timeLeft = 0;
        oClock.drawTimer = false;
    }
    statusMessage = "";
    statusTimer = 0;
    drawOLetterOnDashes = false;
    letters = [];
    letterCount = 0;
	global.currentWordConfidence = [];
    for (var i = 0; i < letterCount; i++) {
        global.currentWordConfidence[i] = -1;
    }
    global.gameComplete = true;
    return;
}
if (instance_exists(oClock) && oClock.timeLeft <= 0) {
    if (currentIndex < letterCount) {
        for (var z = currentIndex; z < letterCount; z++) {
            letterColor[z] = c_red;
            letterAlpha[z] = 1.0;
            ds_list_add(global.wasWrongLetters, letters[z]);
        }
        if (wordIndex < wordsTotal) {
            var finishedWord = ds_list_find_value(wordsDS, wordIndex);
            show_debug_message("Time ran out for word: " + finishedWord);
            ds_list_add(global.incorrectWords, finishedWord);
            var incWords = "Incorrect Words: ";
            for (var i = 0; i < ds_list_size(global.incorrectWords); i++) {
                incWords += ds_list_find_value(global.incorrectWords, i) + " ";
            }
            show_debug_message(incWords);
        }
        statusMessage = "Time Is Up!";
        statusTimer = 30;
        wordsCompleted++;
        wordIndex++;
        nextWordDelay = room_speed * 0.5;
        return;
    }
}
if (currentIndex >= letterCount) {
    if (letters != undefined && letterCount > 0 && wordIndex < wordsTotal) {
        var doneWord = ds_list_find_value(wordsDS, wordIndex);
        show_debug_message("Word Complete: " + doneWord);
        statusMessage = "Good Job!";
        statusTimer = 30;
    }
    wordsCompleted++;
    wordIndex++;
    if (wordIndex >= wordsTotal) {
        show_debug_message("Well Done!");
        statusMessage = "";
        statusTimer = 0;
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
if (global.letter != "") {
    var neededChar = (letterCount > 0) ? letters[currentIndex] : "";
    if (string_lower(global.letter) == string_lower(neededChar)) {
        ds_list_add(global.correctLetters, string_upper(neededChar));
        if (letterWasWrong[currentIndex]) {
            letterColor[currentIndex] = c_green;
            global.score += 1;
            global.scoreGained += 1;
        } else {
            letterColor[currentIndex] = c_green;
            global.score += 2;
            global.scoreGained += 2;
        }
        letterAlpha[currentIndex] = 1.0;
        var pair = [string_upper(neededChar), global.confidence];
        ds_list_add(global.confidenceLetters, pair);
        show_debug_message("Stored letter-confidence pair: " + pair[0] + " : " + string(pair[1]));
        global.currentWordConfidence[currentIndex] = global.confidence;
        currentIndex++;
        if (letterWasWrong[currentIndex - 1]) {
            var correctedLetter = string_upper(global.letter);
            ds_list_add(global.wasWrongLetters, correctedLetter);
            letterWasWrong[currentIndex - 1] = false;
        }
    } else {
        var wrongChar = string_upper(global.letter);
        ds_list_add(global.wrongLetters, wrongChar);
        wrongLetter = wrongChar;
        wrongLetterAlpha = 0.8;
        letterWasWrong[currentIndex] = true;
        wrongLetterX = xPositions[currentIndex];
        wrongLetterY = yPositions[currentIndex];
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
if (statusTimer > 0) {
    statusTimer--;
    if (statusTimer <= 0) {
        statusMessage = "";
    }
}