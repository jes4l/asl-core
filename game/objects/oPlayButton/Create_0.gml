loadingDuration = 20 * room_speed; // 20
elapsedTime = 0;
barPadding = 10;
draw_set_font(fnt_letter_smallest);
loadingText = "Get Ready to Play";
textWidth = string_width(loadingText);
textHeight = string_height(loadingText);
barWidth = textWidth + barPadding * 2;
barHeight = textHeight + barPadding * 2;
x1 = (room_width - barWidth) / 2;


y1 = (1 - 0.35) * room_height - barHeight / 2;

centerText = "SLgame";

draw_set_font(fnt_letter);
centerTextWidth = string_width(centerText);
centerTextHeight = string_height(centerText);
centerTextX = (room_width - centerTextWidth) / 2;
centerTextY = (room_height * 0.65 - centerTextHeight) / 2 + 20;

draw_set_font(fnt_letter_smallest);
loadingTextX = (room_width - textWidth) / 2;
loadingTextY = centerTextY + centerTextHeight + 10;
