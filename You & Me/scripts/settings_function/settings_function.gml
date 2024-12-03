function draw_audio_slider(_input, _count){
	var _spr_bar = spr_settings_audio_bar;
	var _spr_notch = spr_settings_audio_notch;
	var _bar_wid = sprite_get_width(_spr_bar);
	var _bar_hei = sprite_get_height(_spr_bar);
	var _bar_x = obj_settings.cont_txt_x + 800;
	var _bar_y = obj_settings.cont_txt_y + string_height(obj_settings.audios[0][0])/2;
	var _notch_wid = sprite_get_width(_spr_notch);
	var _notch_hei = sprite_get_height(_spr_notch);
	var _notch_buff_x = _bar_wid;
	var _notch_buff_y = 30;
	var _notch_x = _bar_x-_notch_wid/2;
	var _notch_y = _bar_y + _bar_hei;
	var _max = _bar_wid/_notch_wid;
	var _mx = device_mouse_x_to_gui(0);
	var _my = device_mouse_y_to_gui(0);
	var _res = _input;
	
	
	var _y = _bar_y + (_count*obj_settings.cont_txt_buff);
	var _n_y = _notch_y + (_count*obj_settings.cont_txt_buff);
	
	if mouse_check_button_pressed(mb_left) {
		var _n_x = _notch_x + _notch_wid*_input;
		if point_in_rectangle(_mx, _my, _n_x-_notch_buff_x, _n_y-_notch_buff_y, 
		_n_x+_notch_wid+_notch_buff_x, _n_y+_notch_hei+_notch_buff_y) {
			obj_settings.is_selected = 1;
			_cur_count = _count;
		};
	};
	
	if !mouse_check_button(mb_left) { obj_settings.is_selected = 0 };
	
	if obj_settings.is_selected && _cur_count == _count { _res = clamp((_mx-_bar_x)/_notch_wid, 0, _max) };
	
	draw_sprite(_spr_bar, 0, _bar_x, _y);
	draw_sprite(_spr_notch, 0, _notch_x + _notch_wid*_res, _n_y);
	
	return _res;
	
}

function draw_toggle_check(_input, _count){
	
	var _spr_tog = spr_settings_toggle_on;
	var _tog_wid = sprite_get_width(_spr_tog);
	var _tog_hei = sprite_get_height(_spr_tog);
	var _tog_x = obj_settings.cont_txt_x + 1100; 
	var _tog_y = obj_settings.cont_txt_y + _tog_hei/2;
	var _mx = device_mouse_x_to_gui(0);
	var _my = device_mouse_y_to_gui(0);
	var _ans = _input;
	
	var _y = _tog_y + (_count*obj_settings.cont_txt_buff)

	if point_in_rectangle(_mx, _my, _tog_x, _y, _tog_x+_tog_wid, _y+_tog_hei) {
		if mouse_check_button_pressed(mb_left) {
			_ans = !_input;
			return _ans;
		};
	};
	
	if _input { 
		_spr_tog = spr_settings_toggle_on
	} else { _spr_tog = spr_settings_toggle_off };
	
	draw_sprite(_spr_tog, 0, _tog_x, _y);
	
	return _ans;

}

function draw_toggle_count(_input, _count) {
	
	var _spr_count = spr_settings_toggle_count;
	var _spr_arrow = spr_settings_toggle_count_arrow;
	var _count_wid = sprite_get_width(_spr_count);
	var _count_hei = sprite_get_height(_spr_count);
	var _arrow_wid = sprite_get_width(_spr_arrow);
	var _arrow_hei = sprite_get_height(_spr_arrow);
	var _count_x = obj_settings.cont_txt_x + 1050; 
	var _count_y = obj_settings.cont_txt_y;
	var _arrow_x = _count_x-_arrow_wid;
	var _mx = device_mouse_x_to_gui(0);
	var _my = device_mouse_y_to_gui(0);
	var _res = _input;
	var _alpha_l = 1;
	var _alpha_r = 1;
	
	var _y = _count_y + (_count*obj_settings.cont_txt_buff);
	
	if mouse_check_button_released(mb_left) { obj_settings.timer = 0 };
	
	//Left button
	if point_in_rectangle(_mx, _my, _arrow_x, _y, _arrow_x+_arrow_wid, _y+_arrow_hei) {
		if mouse_check_button(mb_left) {
			_alpha_l = 0.75;	
			if _input > 1 {
				if obj_settings.timer == 0 { 
					_res--
					obj_settings.timer = 10;
					alarm_set(0, timer);
				};
			};
		};
	};
	
	draw_sprite_ext(_spr_arrow, 0, _arrow_x, _y, 1, 1, 0, c_white, _alpha_l);
	
	//Right button
	_arrow_x = _count_x+_count_wid+_arrow_wid;
	if point_in_rectangle(_mx, _my, _arrow_x-_arrow_wid, _y, _arrow_x, _y+_arrow_hei) {
		if mouse_check_button(mb_left) {
			_alpha_r = 0.75;
			if _input < obj_master.max_text_speed {
				if obj_settings.timer == 0 { 
					_res++
					obj_settings.timer = 10;
					alarm_set(0, timer);
				};
			};
		};
	};
	
	var _string = string(_input)
	var _txt_x = _count_x + _count_wid/2 - string_width(_string)/2;
	
	draw_sprite(_spr_count, 0, _count_x, _y);
	draw_set_color(c_black);
	draw_text(_txt_x, _y, _string)
	draw_sprite_ext(_spr_arrow, 0, _arrow_x, _y, -1, 1, 0, c_white, _alpha_r);
	draw_set_color(c_white);
	
	return _res;
	
};

function draw_settings_button(_count) {
	
	var _spr_button = spr_settings_toggle_count;
	var _button_wid = sprite_get_width(_spr_arrow);
	var _button_hei = sprite_get_height(_spr_arrow);
	var _button_x = obj_settings.cont_txt_x + 1050; 
	var _butt_y = obj_settings.cont_txt_y;
	var _mx = device_mouse_x_to_gui(0);
	var _my = device_mouse_y_to_gui(0);
	var _res = _input;
	var _alpha_l = 1;
		
		
};