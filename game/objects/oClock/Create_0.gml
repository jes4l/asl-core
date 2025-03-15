function ResetClock() {
    if (instance_exists(oLetterOnDashes)) {
        timeLeft = oLetterOnDashes.letterCount * 0.5; 
    } else {

        timeLeft = string_length(global.activeWords[0]) * 0.5;
    }
}


timeLeft = 0;
ResetClock();
