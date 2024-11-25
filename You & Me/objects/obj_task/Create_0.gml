//Window
window_sprite = spr_task;
window_width = sprite_get_width(window_sprite);
window_height = sprite_get_height(window_sprite);
window_margin = 25;
tab_margin = 75;
window_x = room_width - window_margin;
window_y = window_margin;
window_index = 0;
window_anim_speed = sprite_get_number(window_sprite)/game_get_speed(gamespeed_fps);

//Text
draw_set_font(fnt_debug);
text_margin = 100;

tasks = task_list_init();
tasks_active = [];

access = 1;
hidden = 0;
last_clicked = -1;

