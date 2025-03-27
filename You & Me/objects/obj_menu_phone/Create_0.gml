phone_sprite = spr_phone_debug;
phone_x = room_width/2;
phone_y = 30;
phone_width = sprite_get_width(phone_sprite);
phone_height = sprite_get_height(phone_sprite);

_is_interactable = 1;
apps = [[spr_app_gallery, "Gallery"], [spr_app_map, "Map"], [spr_app_music, "Music"], 
[spr_app_settings, "Settings"], [spr_app_text, "Texts"], [spr_app_weather, "Weather"], [spr_app_to_title, "Return to Title"]];
apps[0][2] = function(){ with obj_master{event_user(0)}; draw_phone_gallery() }; 
apps[1][2] = function(){ load_app_TEMP() };
apps[2][2] = function(){ draw_phone_music() };
apps[3][2] = function(){ instance_create_layer(-1, -1, "Instances_inv", obj_settings) };
apps[4][2] = function(){ instance_create_layer(-1, -1, "Instances_inv", obj_messages) };
apps[5][2] = function(){ load_app_TEMP() };
apps[6][2] = function(){ room_goto(rm_title) };

app_margin_outer = 65;
app_margin_inner = 62;
app_x = phone_x - (phone_width/2) + app_margin_outer;
app_y = phone_y + app_margin_outer;
app_width = sprite_get_width(spr_app_gallery);
app_height = sprite_get_height(spr_app_gallery)
app_alpha = 1;
text_buff_y = 800;

_is_active = 0;
_cur = 0;
_cur_photo = 0;

depth = -1200;




