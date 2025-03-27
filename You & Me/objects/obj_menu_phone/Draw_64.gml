var _mx = device_mouse_x_to_gui(0);
var _my = device_mouse_y_to_gui(0);
var _app = 0;
	
	draw_set_color(c_black); draw_set_alpha(0.75);
	draw_rectangle(0, 0, room_width, room_height, 0);
	draw_set_color(c_white); draw_set_alpha(1);
	draw_sprite(spr_phone_debug, -1, phone_x, phone_y);
	
	var _check = ceil(array_length(apps)/3);
	for (var _i = 0; _i < _check; _i++) { //Rows
		var _count = (array_length(apps)-_app);
		
		if _count > 3 { _count = 3 };
		
		for (var _ii = 0; _ii < _count; _ii++) { //Columns
			var _x = app_x+(_ii*(app_width+app_margin_inner))
			var _y = app_y+(_i*(app_height+app_margin_inner))
			
			if !_is_active {
				if point_in_rectangle(_mx, _my, _x, _y, _x+app_width, _y+app_height) { 
					_cur = _app;
					app_alpha = 0.5 
					draw_set_halign(fa_center);
					draw_text(phone_x, phone_y+text_buff_y, apps[_app][1]);
					draw_set_halign(fa_left);
					if mouse_check_button_pressed(mb_left) { _is_active = 1 };
			
				} else { app_alpha = 1 };
				
					draw_sprite_ext(apps[_app][0], -1, _x, _y, 1, 1, 0, c_white, app_alpha);
				
			};	
					
			if _is_active && _cur == _app {
				apps[_app][2]();
			};
			
			_app++;
			
		};
	};

