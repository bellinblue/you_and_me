var _mx = device_mouse_x_to_gui(0);
var _my = device_mouse_y_to_gui(0);

for (var _i = 0; _i < array_length(buttons); _i++) {
	var _x = button_x+(_i*(button_width+button_margin))
	
	if point_in_rectangle(_mx, _my, _x, button_y, _x+button_width, button_y+button_height) {
		button_alpha = 0.5;
		
		if mouse_check_button_pressed(mb_left) { buttons[_i][1]() };
		
	} else { button_alpha = 1 };
	
	draw_sprite_ext(button_sprite, -1, _x, button_y, 1, 1, 0, c_white, button_alpha);
	draw_text(_x + text_margin, button_y, buttons[_i][0]);
};


