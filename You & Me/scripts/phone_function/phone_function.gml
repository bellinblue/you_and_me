function draw_phone_gallery(){
	draw_set_color(c_black); draw_set_alpha(0.75);
	draw_rectangle(0,0,room_width,room_height,0);
	draw_set_color(c_white); draw_set_alpha(1);
	
	var _spr_win = spr_gallery_background;
	var _win_wid = sprite_get_width(_spr_win);
	var _win_hei = sprite_get_height(_spr_win);
	var _win_x = (room_width-_win_wid)/2
	var _win_y = (room_height-_win_hei)/2;
	var _spr_arrow = spr_gallery_arrow;
	var _arr_wid = sprite_get_width(_spr_arrow);
	var _arr_hei = sprite_get_height(_spr_arrow);
	var _arr_x = _win_x + (_win_wid/2) - _arr_wid;
	var _arr_y = _win_y +_win_hei - 125;
	var _arr_buff = 30;
	var _mx = device_mouse_x_to_gui(0);
	var _my = device_mouse_y_to_gui(0);
	var _alpha_l = 0;
	var _alpha_r = 0;
	
	var _x_l = _arr_x - _arr_buff;
	if point_in_rectangle(_mx, _my, _x_l, _arr_y, _x_l + _arr_wid, _arr_y+_arr_hei) {
		_alpha_l = 0.75;
		if mouse_check_button_pressed(mb_left) { 
			if _cur_photo <= 0 {
				obj_menu_phone._cur_photo = array_length(obj_master.gallery_available)-1;
			} else { obj_menu_phone._cur_photo-- };
		};
	} else { _alpha_l = 1 };
	
	var _x_r = _arr_x + 2*_arr_wid + _arr_buff
	if point_in_rectangle(_mx, _my, _x_r - _arr_wid, _arr_y, _x_r, _arr_y+_arr_hei) { 
		_alpha_r = 0.75 
		if mouse_check_button_pressed(mb_left) { 
			if _cur_photo >= array_length(obj_master.gallery_available)-1 {
				obj_menu_phone._cur_photo = 0;
			} else { obj_menu_phone._cur_photo++ };
		};
	} else { _alpha_r = 1 };
	
	draw_sprite(_spr_win, 0, _win_x, _win_y);
	draw_sprite_ext(_spr_arrow, 0, _x_l, _arr_y, 1, 1, 0, c_white, _alpha_l);
	draw_sprite_ext(_spr_arrow, 0, _x_r, _arr_y, -1, 1, 0, c_white, _alpha_r);
	
	if keyboard_check_pressed(vk_escape) {
		obj_menu_phone._is_active = 0;	
	}
	
	var _photo_x = room_width/2;
	var _photo_y = room_height/2 - 25;
	var _grabbed = obj_master.gallery_available[obj_menu_phone._cur_photo]
	var _pho_hei = sprite_get_height(asset_get_index(_grabbed[2]));
	draw_sprite(asset_get_index(_grabbed[2]), 0, _photo_x, _photo_y);	
	draw_text(_photo_x-string_width(_grabbed[1])/2, _photo_y-_pho_hei/2-85, _grabbed[1]);
	
};

function draw_phone_music(){
	var _bck_spr = spr_music_background;
	var _bck_wid = sprite_get_width(_bck_spr);
	var _bck_hei = sprite_get_height(_bck_spr);
	var _bck_x = 0;
	var _bck_y = 0;
	
	
	
	
};

function load_app_TEMP(){
	if mouse_check_button_pressed(mb_left) { obj_menu_phone._is_active = 0 };
};