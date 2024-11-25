roleButtonText = "Scan";
buttonPadding = 10;

draw_set_font(fnt_letter_smallest);
roleTextWidth = string_width(roleButtonText);
roleTextHeight = string_height(roleButtonText);

roleButtonWidth = roleTextWidth + buttonPadding * 2;
roleButtonHeight = roleTextHeight + buttonPadding * 2;

roleX1 = room_width - roleButtonWidth - buttonPadding;
roleY1 = room_height - roleButtonHeight - buttonPadding;
roleX2 = roleX1 + roleButtonWidth;
roleY2 = roleY1 + roleButtonHeight;