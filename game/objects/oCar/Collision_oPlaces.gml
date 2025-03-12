var targetRoom = asset_get_index("rmPlacesGame" + global.activeWords[0]);
room_goto(targetRoom);
instance_destroy(other);
