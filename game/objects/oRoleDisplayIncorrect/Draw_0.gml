if (global.oRoleGameIncorrectSprites != undefined) {
    var count = ds_list_size(global.oRoleGameIncorrectSprites);
    if (count > 0) {
        var scale = 0.75;
        var gap = 20;
        var bottom_padding = 32;
        
        var total_width = 0;
        for (var i = 0; i < count; i++) {
            var spr = global.oRoleGameIncorrectSprites[| i][? "sprite"];
            var spr_w = sprite_get_width(spr) * scale;
            total_width += spr_w;
        }
        total_width += gap * (count - 1);
        
        var start_left = (room_width - total_width) / 2;
        var anchor_y = room_height - bottom_padding;

        var current_left = start_left;
        for (var i = 0; i < min(visible_sprites, count); i++) {
            var spr_data = global.oRoleGameIncorrectSprites[| i];
            var spr = spr_data[? "sprite"];
            
            var ox = sprite_get_xoffset(spr);
            var oy = sprite_get_yoffset(spr);
            var spr_w = sprite_get_width(spr) * scale;
            var spr_h = sprite_get_height(spr) * scale;
            
            var draw_x = current_left + ox * scale;
            var draw_y = anchor_y - (sprite_get_height(spr) - oy) * scale;
            
            draw_sprite_ext(spr, 2, draw_x, draw_y, scale, scale, 0, c_white, 1);
            
            current_left += spr_w + gap;
        }
    }
}
