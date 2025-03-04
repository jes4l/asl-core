var bagCount = ds_list_size(bagList);
for (var i = 0; i < bagCount; i++) {
    var bag = bagList[| i];
    var bag2 = bag2List[| i];
    if (bag != noone) {
        var spr1 = bag.sprite_index;
        draw_sprite(spr1, 0, bag.x, bag.y);
        
        var bagW = sprite_get_width(spr1);
        var bagH = sprite_get_height(spr1);
        var centerX = bag.x + bagW * 0.5;
        var centerY = bag.y + bagH * 0.5;
        var wordSpr = scrGetWordPoolSprite(bag.activeWord, false);
        var wordW = sprite_get_width(wordSpr);
        var wordH = sprite_get_height(wordSpr);
        draw_sprite(wordSpr, 0, centerX - wordW * 0.5 - 60, centerY - wordH * 0.5 - 150);
    }
    if (bag2 != noone) {
        var spr2 = bag2.sprite_index;
        draw_sprite(spr2, 0, bag2.x, bag2.y);
    }
}
