draw_rectangle_color(0, 0, room_width, room_height, c_grey, c_grey, c_grey, c_grey, 0);
draw_sprite(wnd_t_spr, 0, wnd_t_x, wnd_t_y);
draw_sprite(wnd_e_spr, 0, wnd_e_x, wnd_e_y);

draw_set_color(c_black);

draw_set_halign(fa_center);
draw_text_transformed(ti_txt_x, ti_txt_y, ques_string, 0.75, 0.75, 0);
draw_set_halign(fa_left);

var _mx = device_mouse_x_to_gui(0);
var _my = device_mouse_y_to_gui(0);

#region //Draw evidence window
for (var _iii = 0; _iii < array_length(evidence); _iii++) {
	var _spr = asset_get_index(evidence[_iii][2]);
	var _spr_widt = sprite_get_width(_spr);
	var _spr_heig = sprite_get_height(_spr);
	
	if _is_selecting > -1 { if alarm_get(0) <= 0 { alarm_set(0, 5) } } else { evi_alpha = 1; evi_dir = 1 };
	draw_sprite_ext(_spr, 0, evi_x, evi_y + (_iii*evi_buff_y), 1, 1, 0, c_white, evi_alpha);
	
	var _col_x = evi_x-(_spr_widt/2);
	var _col_y = evi_y - (_spr_heig/2) + (_iii*evi_buff_y);
	evi_name_x = (wnd_e_x-(wnd_e_wid/2))-(string_width(evidence[_iii][1])/2);
	
	draw_set_color(c_white);
	if point_in_rectangle(_mx, _my, _col_x, _col_y, _col_x + _spr_widt, _col_y + _spr_heig) 
		{
		if _is_selecting > -1 {
			draw_text(evi_name_x, evi_name_y, evidence[_iii][1]);
			if mouse_check_button_pressed(mb_left) {
				evi_cur = _iii;
				if answers[_is_selecting][1] == evidence[evi_cur][0] {
					answers[_is_selecting][1] = undefined;
				} 
				else { 
					answers[_is_selecting][1] = evidence[evi_cur][0]
					for (var _a = 0; _a < array_length(answers); _a++) {
						if answers[_is_selecting][1] == answers[_a][1] && _a != _is_selecting {
							answers[_a][1] = undefined;
						};
					};
				};
				 evi_alpha = 1; 
				_is_selecting = -1;
			};
		};
	};
};
#endregion

#region //Draw test window
for (var _i = 0; _i < ques_count; _i++) {
	var _x = ques_txt_x;
	var _y_ques = _i*(ques_txt_buff)+ques_txt_y+ti_txt_y;
	var _y_box = _y_ques + tf_box_buff_y;
	
	var _spr_pap = spr_puzzle_evidence_paperclip;
	var _spr_wid = sprite_get_width(_spr_pap); 
	var _spr_hei = sprite_get_height(_spr_pap)
	var _spr_buff = 955;
	var _spr_x = _x + _spr_buff;
	var _spr_y = _y_ques
	var _check_buff = 40;
	
	if answers[_i][1] != undefined {
		var _ind = 0;
		for (var _a = 0; _a < array_length(evidence); _a++) {
			if answers[_i][1] == evidence[_a][0] {
				_ind = _a;	
			};
		};
		
		draw_sprite(asset_get_index(evidence[_ind][2]), 0, _spr_x+50, _spr_y-70);	
		
	};

	draw_sprite(_spr_pap, 0, _spr_x, _spr_y);
	
	if point_in_rectangle(_mx, _my, _spr_x - _check_buff, _spr_y - _check_buff, 
	_spr_x + _spr_wid + _check_buff, _spr_y+_spr_hei + _check_buff) {
		var _str = string("Select or stop selecting\nevidence for answer {0}", _i+1);
		draw_set_color(c_white); draw_set_alpha(0.5);
		draw_rectangle(_mx+50, _my-100, _mx+50+string_width(_str), _my-100+string_height(_str), 0)
		draw_set_color(c_black); draw_set_alpha(1);
		draw_text(_mx + 50, _my - 100, _str);
		
		if mouse_check_button_pressed(mb_left) { 
			if _is_selecting > -1 { _is_selecting = -1 } else { _is_selecting = _i };
		};
	};
	
	draw_set_color(c_black);
	draw_text(ques_txt_x, _y_ques, questions[_i][0]);
	
	switch questions[_i][1] {
		case "bool":
			var _rec = [[_x + tf_box_buff_x, _y_box, _x + tf_box_buff_x + tf_box_size, _y_box + tf_box_size],
				[_x + (2*tf_box_buff_x), _y_box, _x + (2*tf_box_buff_x) + tf_box_size, _y_box + tf_box_size]];
			
			var _buff = 20;
			if point_in_rectangle(_mx, _my, _rec[0][0]-_buff, _rec[0][1]-_buff, _rec[0][2]+_buff, _rec[0][3]+_buff) {
				tf_attr[0] = 0.5;
				if mouse_check_button_pressed(mb_left) {
					if tf_attr[2] == 0 {
						tf_attr[2] = 1;
						tf_attr[3] = 0;
						answers[_i][0] = 1;	
					} else {
						tf_attr[2] = 0;
						answers[_i][0] = undefined;
					};
				};
			} else { tf_attr[0] = 1 }; 
			
			if point_in_rectangle(_mx, _my, _rec[1][0]-_buff, _rec[1][1]-_buff, _rec[1][2]+_buff, _rec[1][3]+_buff) {
				tf_attr[1] = 0.5;
				if mouse_check_button_pressed(mb_left) {
					if tf_attr[3] == 0 {
						tf_attr[2] = 0;
						tf_attr[3] = 1;
						answers[_i][0] = 0;
					} else {
						tf_attr[3] = 0;
						answers[_i][0] = undefined;
					};
				};
			} else { tf_attr[1] = 1 }; 
			
			draw_set_alpha(tf_attr[0]); draw_set_color(c_grey);
			draw_rectangle(_rec[0][0], _rec[0][1], _rec[0][2], _rec[0][3], 0);
			draw_set_alpha(tf_attr[1]);
			draw_rectangle(_rec[1][0], _rec[1][1], _rec[1][2], _rec[1][3], 0);
			draw_set_alpha(1); draw_set_color(c_black);
			draw_text(_x + tf_box_buff_x + tf_box_size + 20, _y_box - tf_box_size, "True");
			draw_text(_x + (2*tf_box_buff_x) + tf_box_size + 20, _y_box - tf_box_size, "False");
			
			if tf_attr[2] == 1 { draw_sprite(spr_puzzle_evidence_checkmark, 0, _rec[0][0], _rec[0][1]) };
			if tf_attr[3] == 1 { draw_sprite(spr_puzzle_evidence_checkmark, 0, _rec[1][0], _rec[1][1]) };
			
		break;
		
		case "mc":
			for (var _ii = 0; _ii < 3; _ii++) {
				
				var _mc_x = _x + (_ii*mc_buff_x);
				var _mc_y = _y_ques + mc_buff_y;
				var _string = string("{0}: {1}", _ii+1, questions[_i][2+_ii]);
				
				if point_in_rectangle(_mx, _my, _mc_x, _mc_y, _mc_x+string_width(_string), _mc_y+string_height(_string)) {
					mc_alpha = 0.25;
					if mouse_check_button_pressed(mb_left) {
						if answers[_i][0] == _ii { answers[_i][0] = undefined } else { answers[_i][0] = _ii };
					};
				} else { mc_alpha = 1 };
				
				draw_set_alpha(mc_alpha);
				draw_text(_mc_x, _mc_y, _string);
				draw_set_alpha(1);
				if answers[_i][0] == _ii {
					draw_sprite(spr_puzzle_evidence_circle, 0, _mc_x, _mc_y+string_height(_string)/4);
				};
			};
		break;
		
		case "oe":
			var _line_x = _x + oe_buff_x;
			var _line_y = _y_ques + oe_buff_y;
			draw_line_width(_line_x, _line_y, _line_x + oe_line_len, _line_y, 7);
			
			draw_set_color(c_grey);
			draw_set_alpha(oe_inp_alpha);
			draw_rectangle(_line_x, _line_y-oe_inp_hei, _line_x + oe_line_len, _line_y, 0);
			draw_set_color(c_black);
			draw_set_alpha(0.75);
			
			if writing {
				oe_inp_alpha = 0.25;
				writing_string = string_copy(keyboard_string, 1, 40);
			} else { 
				oe_inp_alpha = 0.75;
			};
			draw_text(_line_x, _line_y-oe_inp_hei, writing_string);
			
			if !point_in_rectangle(_mx, _my, _line_x, _line_y-oe_inp_hei, _line_x + oe_line_len, _line_y) {
				if mouse_check_button_pressed(mb_left) { writing = 0 };
			};
			
			if point_in_rectangle(_mx, _my, _line_x, _line_y-oe_inp_hei, _line_x + oe_line_len, _line_y) {
				oe_inp_alpha = 0.25;
				if mouse_check_button_pressed(mb_left) {
					keyboard_string = writing_string;
					writing = 1;	
				};
			};
			draw_set_color(c_white);
			draw_set_alpha(1);
			answers[_i][0] = writing_string;
		break;
	};
	
};
#endregion




