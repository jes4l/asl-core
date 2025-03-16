centerX = 964;
centerY = 150;
fontToUse = fntSevenSegment40;
textColor = c_white;
textAlpha = 1;
displayStage = 0;
timer = 0;

hasCorrect = (ds_list_size(global.oRoleGameSprites) > 0);
hasIncorrect = (ds_list_size(global.oRoleGameIncorrectSprites) > 0);

if (hasCorrect) {
    instance_create_layer(0, 0, "Instances_3", oRoleDisplayCorrect);
} else if (hasIncorrect) {
    instance_create_layer(0, 0, "Instances_3", oRoleDisplayIncorrect);
}

msg1 = "Thank You For Filling In Our Tax Form:";

if (hasCorrect) {
    var activeWordsStr = "";
    for (var i = 0; i < ds_list_size(global.oRoleGameSprites); i++) {
        var sprMap = global.oRoleGameSprites[| i];
        activeWordsStr += sprMap[? "word"];
        if (i < ds_list_size(global.oRoleGameSprites) - 1) {
            activeWordsStr += ", ";
        }
    }
    msg2 = " you have correctly identified\n" + activeWordsStr;
} else {
    var incorrectWordsStr = "";
    for (var i = 0; i < ds_list_size(global.oRoleGameIncorrectSprites); i++) {
        var sprMap = global.oRoleGameIncorrectSprites[| i];
        incorrectWordsStr += sprMap[? "word"];
        if (i < ds_list_size(global.oRoleGameIncorrectSprites) - 1) {
            incorrectWordsStr += ", ";
        }
    }
    msg2 = " you have failed to identified\n" + incorrectWordsStr;
}
if (hasIncorrect) {
    var incorrectWordsStr = "";
    for (var i = 0; i < ds_list_size(global.oRoleGameIncorrectSprites); i++) {
        var sprMap = global.oRoleGameIncorrectSprites[| i];
        incorrectWordsStr += sprMap[? "word"];
        if (i < ds_list_size(global.oRoleGameIncorrectSprites) - 1) {
            incorrectWordsStr += ", ";
        }
    }
    msg3 = "But you failed to identify\n" + incorrectWordsStr;
}

msg4 = "You Got A Tip Of " + string(global.scoreGained) + "\nThis Is Your Overall Tips " + string(global.score);