total_sprites = ds_list_size(global.oRoleGameIncorrectSprites);

if (total_sprites > 0) {
    visible_sprites = 1;
    if (total_sprites > 1) {
        alarm[0] = room_speed * 2;
    }
} else {
    visible_sprites = 0;
}
