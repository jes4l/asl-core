colourButtonText = "Heal";
buttonPadding = 10;

draw_set_font(fnt_letter_smallest);
colourTextWidth = string_width(colourButtonText);
colourTextHeight = string_height(colourButtonText);

colourButtonWidth = colourTextWidth + buttonPadding * 2;
colourButtonHeight = colourTextHeight + buttonPadding * 2;

colourX1 = room_width - colourButtonWidth - buttonPadding;
colourY1 = room_height - colourButtonHeight - buttonPadding;
colourX2 = colourX1 + colourButtonWidth;
colourY2 = colourY1 + colourButtonHeight;