/// oClock - Create Event

// We define ResetClock() here so oLetterOnDashes can call it.
// This ensures we always get the correct letterCount *after each word load.
function ResetClock() {
    if (instance_exists(oLetterOnDashes)) {
        timeLeft = oLetterOnDashes.letterCount * 5; 
    } else {
        // Fallback if oLetterOnDashes doesn't exist yet
        timeLeft = 60;
    }

    // Start the once-per-second countdown alarm
    alarm[0] = room_speed;
}

// Initialize timeLeft to some default
timeLeft = 60;

// Call ResetClock once when the object is created
ResetClock();
