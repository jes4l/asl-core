if (room == rmPlacesGameLoss) {
    image_index = 2;
} else {
    image_index = 0;
}

if (room == rmPlacesGamePark ||
    room == rmPlacesGameLibrary ||
    room == rmPlacesGameSchool ||
    room == rmPlacesGameMuseum ||
    room == rmPlacesGameCinema) {
    draw_sprite_ext(global.chosenSprite, 3, 440, 600, 0.5, 0.5, 0, c_white, 1);
} else {
    draw_sprite_ext(global.chosenSprite, 3, 440, 800, 1.5, 1.5, 0, c_white, 1);
}