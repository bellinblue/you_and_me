draw_set_color(c_black); draw_set_alpha(0.75);
draw_rectangle(0, 0, room_width, room_height, 0);
draw_set_color(c_white); draw_set_alpha(1);
draw_sprite(spr_phone_debug, -1, phone_x, phone_y);

var _mx = device_mouse_x_to_gui(0);
var _my = device_mouse_y_to_gui(0);
var _app = 0;

for (var _i = 0; _i < (ceil(array_length(apps)/3)); _i++) {
	for (var _ii = 0; _ii < 3; _ii++) {
		
		var _x = app_x+(_ii*(app_width+app_margin_inner))
		var _y = app_y+(_i*(app_height+app_margin_inner))
		
		if point_in_rectangle(_mx, _my, _x, _y, _x+app_width, _y+app_height) { 
			app_alpha = 0.5 
			draw_set_halign(fa_center);
			draw_text(phone_x, phone_y+500, apps[_app][1]);
			draw_set_halign(fa_left);
			if mouse_check_button_pressed(mb_left) { apps[_app][2]() };
			
		} else { app_alpha = 1 };
		
		draw_sprite_ext(apps[_app][0], -1, _x, _y, 1, 1, 0, c_white, app_alpha);
		_app++;
		
		
	}
	
};