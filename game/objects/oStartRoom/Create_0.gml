barWidth = room_width * 0.7;
barHeight = 30;
radius = barHeight * 0.5;
bgX = (room_width - barWidth) * 0.5;
bgY = room_height - (room_height * 0.15);
startTime = current_time;
progress = 0;

fontBold = asset_get_index("fntBritanicBold125");
fontSmall = asset_get_index("fntBritanicBold45");
textMain = ""; //SLGame - ASL-Core
textSub = "Get Ready To Play...";

textYMain = room_height * 0.7;
textYSub = textYMain + 125;
