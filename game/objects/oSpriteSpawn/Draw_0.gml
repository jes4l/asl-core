if (room == rmPlacesGamePark || room == rmPlacesGameLibrary || room == rmPlacesGameSchool || room == rmPlacesGameMuseum || room == rmPlacesGameCinema || room == rmPlacesGameCinema) {
    draw_sprite_ext(chosenSprite, image_index, x, y, 0.5, 0.5, 0, c_white, 1);
} else {
    draw_sprite_ext(chosenSprite, image_index, x, y, 1.5, 1.5, 0, c_white, 1);
}
