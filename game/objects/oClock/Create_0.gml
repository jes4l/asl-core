function ResetClock() {
    if (instance_exists(oLetterOnDashes)) {
        timeLeft = oLetterOnDashes.letterCount * 3; 
    } else {

        timeLeft = string_length(global.activeWords[0]) * 3;
    }
}


timeLeft = 0;
ResetClock();
