//Window
window_width = sprite_get_width(spr_text_window);
window_height = sprite_get_height(spr_text_window);
window_sprite_x = 0;
window_sprite_y = 0;
window_sprite = spr_text_window;
window_index = 0;
window_anim_speed = sprite_get_number(window_sprite)/game_get_speed(gamespeed_fps);

//Sprite
sprite_x = 1300;
sprite_y = 405;
sprite_img = -1;

//Text
text_speed = obj_master.text_speed;
font = obj_master.game_font;
text_margin = 50;
line_sep = font_get_size(fnt_debug)*1.5;
line_width = window_width - (text_margin*2);
text[0] = "";
text_len = string_length(text[0]);
page_count = array_length(text);
page = 0;
char[0] = "";
char_x[0, 0] = "";
char_y[0, 0] = "";
draw_char = 0;
char_name = "";

feeder = "";
init = 0;

//Sound
snd_delay = 5;
snd_count = snd_delay;

//FX
text_pause_timer = 0;
text_pause_time = 20;
