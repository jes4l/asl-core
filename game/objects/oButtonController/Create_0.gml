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
