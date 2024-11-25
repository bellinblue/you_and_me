draw_sprite(bkgr_sprite, 0, 0, 0);
draw_sprite(wnd_sprite, 0, wnd_x, wnd_y);

var _mx = device_mouse_x_to_gui(0);
var _my = device_mouse_y_to_gui(0);

for (var _i = 0; _i < array_length(tabs); _i++) {
	var _x = tab_x + (tab_wid*_i);
	
	if point_in_rectangle(_mx, _my, _x, tab_y - tab_hei, _x + tab_wid, tab_y) || tabs[_i][1] == 1 { 
		tab_alpha = 0.5; 
		if mouse_check_button_pressed(mb_left) {
			for (var _ii = 0; _ii < array_length(tabs); _ii++) { tabs[_ii][1] = 0 };
			tabs[_i][1] = 1;
		};
	} else { tab_alpha = 1 };
	
	draw_set_alpha(tab_alpha);
	draw_sprite(tab_sprite, 0, _x, tab_y);
	draw_text(tab_txt_x + (tab_wid*_i), tab_txt_y, tabs[_i][0]);
	draw_set_alpha(1);

	for (var _a = 0; _a < array_length(settings); _a++) {
		var _arr = settings[_a];
		for (var _iii = 0; _iii < array_length(_arr); _iii++){
			if tabs[_a][1] == 1 {
				draw_text(cont_txt_x, cont_txt_y+(_iii*cont_txt_buff), _arr[_iii][0]);	
			} else { break };				
		};
	};

};

