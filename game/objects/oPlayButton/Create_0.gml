loadingDuration = 2 * room_speed; //20
elapsedTime = 0;
barPadding = 10;
draw_set_font(fnt_letter_smallest);
loadingText = "Get Ready to Play";
textWidth = string_width(loadingText);
textHeight = string_height(loadingText);
barWidth = textWidth + barPadding * 2;
barHeight = textHeight + barPadding * 2;
x1 = (room_width - barWidth) / 2;
y1 = (room_height - barHeight) / 2;
