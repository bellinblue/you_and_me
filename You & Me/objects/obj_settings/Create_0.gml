#region //windows
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
tabs = [["Audio", 1], ["Visuals", 0], ["Controls", 0], ["System", 0]];
tab_txt_x = tab_x + 10;
tab_txt_y = tab_y - tab_hei;

cont_txt_margin = 30;
cont_txt_x = wnd_x + cont_txt_margin;
cont_txt_y = wnd_y + cont_txt_margin;
cont_txt_buff = 150;
#endregion

_is_interactable = 1;

#region //audio
is_selected = 0;
var _def = sprite_get_width(spr_settings_audio_bar)/sprite_get_width(spr_settings_audio_notch);
audios = [["Music Volume", _def], ["Ambience Volume", _def], 
["Effects Volume", _def], ["Voice Volume", _def]];
audios[0][2] = function(){ input_aud = draw_audio_slider(audios[0][1], 0); return input_aud };
audios[1][2] = function(){ input_aud = draw_audio_slider(audios[1][1], 1); return input_aud };
audios[2][2] = function(){ input_aud = draw_audio_slider(audios[2][1], 2); return input_aud };
audios[3][2] = function(){ input_aud = draw_audio_slider(audios[3][1], 3); return input_aud };
#endregion

#region //visuals
timer = 0;
toggle_spr = spr_settings_toggle_on;
visuals = [["Cutscene Subtitles", 1], ["Fullscreen Toggle", window_get_fullscreen()], 
["Text Speed", obj_master.text_speed]]//, ["Nudity", 1]];
visuals[0][2] = function(){ input_vis = draw_toggle_check(visuals[0][1], 0); return input_vis };
visuals[1][2] = function(){ input_vis = draw_toggle_check(visuals[1][1], 1); return input_vis };
visuals[2][2] = function(){ input_vis = draw_toggle_count(visuals[2][1], 2); return input_vis };
//visuals[3][2] = function(){ input_vis = draw_toggle_check(visuals[3][1], 3); return input_vis };
#endregion

#region //controls
cur = 0;
cons = [["Tutorials", undefined], ["Key Map"]];
cons[0][1] = function(){ input_cons = draw_settings_button(0, 0); return input_cons }; 
cons[1][1] = function(){ input_cons = draw_settings_button(1, 0); return input_cons };

cons[0][2] = function(){ tutorial_display() };
cons[1][2] = function(){ key_map_setup() };
#endregion

#region //system
system = [["Save Game"], 
["Load Game"], ["End Game", undefined, undefined, 0]];
system[0][1] = function(){ draw_settings_button(0, 1) };
system[1][1] = function(){ draw_settings_button(1, 1) };
system[2][1] = function(){ draw_settings_button(2, 1) };

system[0][2] = function(){ save_game() };
system[1][2] = function(){ load_game() };
system[2][2] = function(){ end_game() };
#endregion

depth = -1100;

