var targetRoom = asset_get_index("rmPlacesGame" + global.activeWords[0]);
room_goto(targetRoom);
global.score += 20;
global.scoreGained += 20
instance_destroy(other);
