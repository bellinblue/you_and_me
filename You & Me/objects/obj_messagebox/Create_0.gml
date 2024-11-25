//Window
window_sprite = spr_message_window;
window_width = sprite_get_width(window_sprite);
window_height = sprite_get_height(window_sprite);
window_margin = 100;
window_x = room_width / 2 - window_margin;
window_y = room_height - window_height - 50;

//Sprite
sprite_x = 1300;
sprite_y = 405;
sprite_img = noone;

//Text
text_speed = 1;
font = obj_master.game_font;
text_margin = 100;
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

feeder = "";
init = 0;

//Sound
snd_delay = 5;
snd_count = snd_delay;

//FX
text_pause_timer = 0;
text_pause_time = 20;

depth = -1000;
