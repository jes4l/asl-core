shoppingButtonText = "Scan";
buttonPadding = 10;

draw_set_font(fnt_letter_smallest);
shoppingTextWidth = string_width(shoppingButtonText);
shoppingTextHeight = string_height(shoppingButtonText);

shoppingButtonWidth = shoppingTextWidth + buttonPadding * 2;
shoppingButtonHeight = shoppingTextHeight + buttonPadding * 2;

shoppingX1 = room_width - shoppingButtonWidth - buttonPadding;
shoppingY1 = room_height - shoppingButtonHeight - buttonPadding;
shoppingX2 = shoppingX1 + shoppingButtonWidth;
shoppingY2 = shoppingY1 + shoppingButtonHeight;