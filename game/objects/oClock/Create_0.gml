/// oClock - Create Event

function ResetClock() {
    if (instance_exists(oLetterOnDashes)) {
        // Each letter = 5 seconds
        timeLeft = oLetterOnDashes.letterCount * 5; 
    } else {

        timeLeft = string_length(global.activeWords[0]) * 5;
    }
}


// Initialize timeLeft to 0 or any default
timeLeft = 0;
ResetClock();
