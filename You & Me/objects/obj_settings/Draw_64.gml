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
	draw_set_color(c_black);
	draw_text(tab_txt_x + (tab_wid*_i), tab_txt_y, tabs[_i][0]);
	draw_set_color(c_white);
	draw_set_alpha(1);

};

if tabs[0][1] == 1 {
	for (var _a = 0; _a < array_length(audios); _a++) {
		draw_text(cont_txt_x, cont_txt_y+(_a*cont_txt_buff), audios[_a][0]);
		var _cur = _a;
		var _res = audios[_a][2]();
		audios[_a][1] = _res;
	};
};

if tabs[1][1] == 1 {
	for (var _b = 0; _b < array_length(visuals); _b++) {
		draw_text(cont_txt_x, cont_txt_y+(_b*cont_txt_buff), visuals[_b][0]);
		var _res = visuals[_b][2]();
		if _b == 2 { 
			visuals[2][1] = _res
			obj_master.text_speed = _res }
		else { visuals[_b][1] = _res };
	};
};


if tabs[2][1] == 1 {
	for (var _c = 0; _c < array_length(cons); _c++) {
		if _is_interactable { draw_text(cont_txt_x, cont_txt_y+(_c*cont_txt_buff), cons[_c][0]) };
		cons[_c][1]();
	};
};

if tabs[3][1] == 1 {
	for (var _d = 0; _d < array_length(system); _d++) {
		if _is_interactable { draw_text(cont_txt_x, cont_txt_y+(_d*cont_txt_buff), system[_d][0]) };
		system[_d][1]();
	};
};
	
	

