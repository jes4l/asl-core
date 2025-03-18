function ResetClock() {
    if (instance_exists(oLetterOnDashes)) {
        timeLeft = oLetterOnDashes.letterCount * 6; 
    } else {

        timeLeft = string_length(global.activeWords[0]) * 4;
    }
}


timeLeft = 0;
ResetClock();
