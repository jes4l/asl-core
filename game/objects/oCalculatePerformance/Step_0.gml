if (keyboard_check_pressed(vk_space)) {
	if (!global.showWorst) {
	    global.showWorst = true;
	    lettersToDisplay = perf.worst;
	    fadeTimer = 0;
	    currentLetter = 0;
	    alphaArray = array_create(array_length(lettersToDisplay), 0);
	} else {
	    room_goto(rmMenu); 
	}
}

if (global.showWorst && keyboard_check_pressed(vk_escape)) {
	room_goto(rmMenu); 
}

fadeTimer += delta_time / 1000000;

if (currentLetter < array_length(lettersToDisplay)) {
	if (fadeTimer >= 0.3) {
	    alphaArray[currentLetter] += fadeSpeed;
	    if (alphaArray[currentLetter] >= 1) {
	        alphaArray[currentLetter] = 1;
	        fadeTimer = 0;
	        currentLetter++;
	    }
	}
}

if (global.showWorst && currentLetter >= array_length(lettersToDisplay)) {
	if (mouse_check_button_pressed(mb_left)) {
	    draw_set_font(fntOpenSans80);
	    var count = array_length(lettersToDisplay);
	    var spriteY = room_height / 3 + 350;
	    var clickOffset = 150;

	    for (var i = 0; i < count; i++) {
	        var letter = lettersToDisplay[i].letter;
	        var posX = (i + 0.5) * (room_width / count);
	        var spriteX = posX + 125;
	        var spriteIndex = scrGetASLSprite(letter);

	        var text_width = string_width(letter);
	        var text_height = string_height(letter);

	        var textY;
	        if (spriteIndex != -1) {
	            var sprW = sprite_get_width(spriteIndex);
	            var sprH = sprite_get_height(spriteIndex);
	            var offset = -100;
	            textY = spriteY + sprH / 2 + offset + text_height / 2;
	        } else {
	            textY = spriteY;
	        }

	        var text_left = posX - text_width / 2;
	        var text_right = posX + text_width / 2;
	        var text_top = textY - text_height / 2 - clickOffset;
	        var text_bottom = textY + text_height / 2 - clickOffset;

	        var clicked = point_in_rectangle(mouse_x, mouse_y, text_left, text_top, text_right, text_bottom);

	        if (spriteIndex != -1) {
	            var spr_left = spriteX - sprW / 2;
	            var spr_right = spriteX + sprW / 2;
	            var spr_top = spriteY - sprH / 2 - clickOffset;
	            var spr_bottom = spriteY + sprH / 2 - clickOffset;
	            clicked = clicked || point_in_rectangle(mouse_x, mouse_y, spr_left, spr_top, spr_right, spr_bottom);
	        }

	        if (clicked) {
	            global.currentWordLetters = [letter];
	            show_debug_message("Clicked on letter: " + letter);
				room_goto(rmFeedbackTest); 
	            break;
	        }
	    }
	}
}