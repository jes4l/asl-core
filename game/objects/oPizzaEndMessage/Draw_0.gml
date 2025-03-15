var pb = instance_find(oPizzaBase, 0);
var incCount = 0;
if (variable_global_exists("incorrectWords") && global.incorrectWords != undefined) {
    incCount = ds_list_size(global.incorrectWords);
}
if (pb != noone) {
    if (!pb.reachedEnd) {
        var msg1_1 = "";
        var msg1_2 = "";
        if (incCount == 0) {
            msg1_1 = "Thank you for creating my\n pizza with:";
            for (var i = 0; i < array_length_1d(global.activeWords); i++) {
                msg1_2 += global.activeWords[i] + " ";
            }
            msg1_2 = string_trim(msg1_2);
        }
        else if (incCount > 0 && incCount < 3) {
            msg1_1 = "You missed an Ingredient\n You create a pizza with";
            for (var i = 0; i < array_length_1d(global.activeWords); i++) {
                var aw = global.activeWords[i];
                var skip = false;
                for (var j = 0; j < ds_list_size(global.incorrectWords); j++) {
                    var incW = ds_list_find_value(global.incorrectWords, j);
                    if (string_lower(aw) == string_lower(incW)) { skip = true; break; }
                }
                if (!skip) {
                    msg1_2 += aw + " ";
                }
            }
            msg1_2 = string_trim(msg1_2);
        }
        else if (incCount >= 3) {
            msg1_1 = "You missed all the Ingredients\n You were meant to create a pizza with";
            for (var i = 0; i < array_length_1d(global.activeWords); i++) {
                msg1_2 += global.activeWords[i] + " ";
            }
            msg1_2 = string_trim(msg1_2);
        }
        scrDrawText(textX, textY, msg1_1, textColor, textAlpha, fontToUse);
        scrDrawText(textX, 470, msg1_2, textColor, textAlpha, fontToUse);
    }
    else {
        if (!scoreShown) {
            alarm[0] = room_speed * 5;
            scoreShown = true;
        }
        var msg2_1 = "You got a Tip of " + string(global.scoreGained) + "\nThis is your overall Tip " + string(global.score);
        var msg2_2 = "";
        if (incCount == 0) {
            msg2_2 = "I cannot wait to eat this!";
        }
        else if (incCount > 0 && incCount < 3) {
            msg2_2 = "I am not happy";
        }
        else if (incCount >= 3) {
            msg2_2 = "I will not be taking this";
        }
        scrDrawText(textX, textY, msg2_1, textColor, textAlpha, fontToUse);
        scrDrawText(textX, 470, msg2_2, textColor, textAlpha, fontToUse);
    }
}
