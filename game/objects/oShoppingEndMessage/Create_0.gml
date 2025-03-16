textX = 580;
textY = 170;
fontToUse = fntSevenSegment40;
textColor = c_white;
textAlpha = 1;
scoreShown = false;
activeWordsText = "";
if (variable_global_exists("activeWords") && global.activeWords != undefined) {
    for (var i = 0; i < array_length_1d(global.activeWords); i++) {
        activeWordsText += global.activeWords[i];
        if (i < array_length_1d(global.activeWords) - 1) {
            activeWordsText += " ";
        }
    }
}
var incorrectCount = 0;
var incorrectWordsText = "";
if (variable_global_exists("incorrectWords") && ds_list_size(global.incorrectWords) > 0) {
    incorrectCount = ds_list_size(global.incorrectWords);
    for (var i = 0; i < incorrectCount; i++) {
        incorrectWordsText += ds_list_find_value(global.incorrectWords, i);
        if (i < incorrectCount - 1) {
            incorrectWordsText += " ";
        }
    }
}
if (incorrectCount == 0) {
    msg1_1 = "Thank You For Scanning My Items:";
    msg1_2 = activeWordsText;
    msg2_1 = "You Got A Tip Of " + string(global.scoreGained) + "\nThis Is Your Overall Tips " + string(global.score);
    msg2_2 = "I love shopping";
} else if (incorrectCount == 1 || incorrectCount == 2) {
    msg1_1 = "You missed some of my shopping items:";
    msg1_2 = incorrectWordsText;
    msg2_1 = "You Got A Tip Of " + string(global.scoreGained) + "\nThis Is Your Overall Tips " + string(global.score);
    msg2_2 = "I am not happy";
} else if (incorrectCount >= 3) {
    msg1_1 = "You failed to scan all of my items\n Now I have shop for these items again:";
    msg1_2 = activeWordsText;
    msg2_1 = "You Got A Tip Of " + string(global.scoreGained) + "\nThis Is Your Overall Tips " + string(global.score);
    msg2_2 = "I want a refund";
}
noBags = room_speed * 7;
