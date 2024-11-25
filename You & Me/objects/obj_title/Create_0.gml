button_sprite = spr_title_button;
button_x = 90;
button_y = 850;
button_margin = 50;
button_width = sprite_get_width(button_sprite);
button_height = sprite_get_height(button_sprite);
button_alpha = 1;

text_margin = 30;
text_x = button_x + text_margin;
text_y = button_y + text_margin;

buttons = [["Start"],["Settings"],["Leave"]];
buttons[0][1] = function(){ room_goto(rm_debug); instance_destroy(obj_title) };
buttons[1][1] = function(){ room_goto(rm_poop); instance_destroy(obj_title) };
buttons[2][1] = function(){ game_end() };