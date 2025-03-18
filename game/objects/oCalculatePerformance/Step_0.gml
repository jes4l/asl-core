if (keyboard_check_pressed(vk_space)) {
    if (!showWorst) {
        showWorst = true;
        lettersToDisplay = perf.worst;
        fadeTimer = 0;
        currentLetter = 0;
        alphaArray = array_create(array_length(lettersToDisplay), 0);
    } else {
        room_goto(rmMenu);
    }
}

if (showWorst && keyboard_check_pressed(vk_escape)) {
    room_goto(rmMenu);
}

fadeTimer += delta_time / 1000000;

if (currentLetter < array_length(lettersToDisplay)) {
    if (fadeTimer >= 1) {
        alphaArray[currentLetter] += fadeSpeed;
        if (alphaArray[currentLetter] >= 1) {
            alphaArray[currentLetter] = 1;
            fadeTimer = 0;
            currentLetter++;
        }
    }
}