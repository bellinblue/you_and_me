bkgr_sprite = spr_settings_background;

wnd_sprite = spr_settings_window;
wnd_wid = sprite_get_width(wnd_sprite);
wnd_hei = sprite_get_height(wnd_sprite);
wnd_x = (room_width/2) - (wnd_wid/2);
wnd_y = (room_height/2) - (wnd_hei/2);

tab_sprite = spr_settings_window_tab;
tab_wid = sprite_get_width(tab_sprite);
tab_hei = sprite_get_height(tab_sprite); 
tab_x = wnd_x;
tab_y = wnd_y;
tab_alpha = 1;
tabs = [["Audio", 1], ["Visuals", 0], ["Gameplay & Controls", 0], ["System", 0]];
tab_txt_x = tab_x + 10;
tab_txt_y = tab_y - tab_hei;

audios = [["Music Volume", undefined], ["Ambience Volume", undefined], 
["Effects Volume", undefined], ["Voice Volume", undefined]];
visuals = [["Cutscene Subtitles", 1], ["Fullscreen Toggle", window_get_fullscreen()], 
["Text Speed", obj_master.text_speed], ["Nudity", 1]];
game_cons = [["Disclaimer", undefined], ["Tutorials", undefined], ["Key Map", undefined]];
system = [["Save Game", undefined], ["Load Game", undefined], ["End Game", undefined]];

settings = [audios, visuals, game_cons, system];

cont_txt_margin = 30;
cont_txt_x = wnd_x + cont_txt_margin;
cont_txt_y = wnd_y + cont_txt_margin;
cont_txt_buff = 150;
