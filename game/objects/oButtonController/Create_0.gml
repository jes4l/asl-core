// Pizza Game Button
pizzaButtonText = "Pizza Game";
buttonPadding = 10;
draw_set_font(fnt_letter_smallest);
pizzaTextWidth = string_width(pizzaButtonText);
pizzaTextHeight = string_height(pizzaButtonText);
pizzaButtonWidth = pizzaTextWidth + buttonPadding * 2;
pizzaButtonHeight = pizzaTextHeight + buttonPadding * 2;

var pizzaHorizontalPosition = 0.1;
var pizzaVerticalPosition = 0.2;

pizzaX1 = room_width * pizzaHorizontalPosition;
pizzaY1 = room_height * pizzaVerticalPosition;
pizzaX2 = pizzaX1 + pizzaButtonWidth;
pizzaY2 = pizzaY1 + pizzaButtonHeight;



// Places Game Button
placesButtonText = "Places Game";
placesTextWidth = string_width(placesButtonText);
placesTextHeight = string_height(placesButtonText);
placesButtonWidth = placesTextWidth + buttonPadding * 2;
placesButtonHeight = placesTextHeight + buttonPadding * 2;

var placesHorizontalPosition = 0.1;
var placesVerticalPosition = 0.4;

placesX1 = room_width * placesHorizontalPosition;
placesY1 = room_height * placesVerticalPosition;
placesX2 = placesX1 + placesButtonWidth;
placesY2 = placesY1 + placesButtonHeight;



// Role Game Button
roleButtonText = "Role Game";
roleTextWidth = string_width(roleButtonText);
roleTextHeight = string_height(roleButtonText);
roleButtonWidth = roleTextWidth + buttonPadding * 2;
roleButtonHeight = roleTextHeight + buttonPadding * 2;

var roleHorizontalPosition = 0.1;
var roleVerticalPosition = 0.6;

roleX1 = room_width * roleHorizontalPosition;
roleY1 = room_height * roleVerticalPosition;
roleX2 = roleX1 + roleButtonWidth;
roleY2 = roleY1 + roleButtonHeight;



// Shopping Game Button
shoppingButtonText = "Shopping Game";
shoppingTextWidth = string_width(shoppingButtonText);
shoppingTextHeight = string_height(shoppingButtonText);
shoppingButtonWidth = shoppingTextWidth + buttonPadding * 2;
shoppingButtonHeight = shoppingTextHeight + buttonPadding * 2;

var shoppingHorizontalPosition = 0.9;
var shoppingVerticalPosition = 0.2;

shoppingX1 = room_width * shoppingHorizontalPosition - shoppingButtonWidth;
shoppingY1 = room_height * shoppingVerticalPosition;
shoppingX2 = shoppingX1 + shoppingButtonWidth;
shoppingY2 = shoppingY1 + shoppingButtonHeight;



// Colours Game Button
coloursButtonText = "Colours Game";
coloursTextWidth = string_width(coloursButtonText);
coloursTextHeight = string_height(coloursButtonText);
coloursButtonWidth = coloursTextWidth + buttonPadding * 2;
coloursButtonHeight = coloursTextHeight + buttonPadding * 2;

var coloursHorizontalPosition = 0.9;
var coloursVerticalPosition = 0.4;

coloursX1 = room_width * coloursHorizontalPosition - coloursButtonWidth;
coloursY1 = room_height * coloursVerticalPosition;
coloursX2 = coloursX1 + coloursButtonWidth;
coloursY2 = coloursY1 + coloursButtonHeight;