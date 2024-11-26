draw_rectangle_color(0, 0, room_width, room_height, c_grey, c_grey, c_grey, c_grey, 0);
draw_sprite(wnd_t_spr, 0, wnd_t_x, wnd_t_y);
draw_sprite(wnd_e_spr, 0, wnd_e_x, wnd_e_y);

draw_set_color(c_black);

draw_set_halign(fa_center);
draw_text_transformed(ti_txt_x, ti_txt_y, ques_string, 0.75, 0.75, 0);
draw_set_halign(fa_left);

var _mx = device_mouse_x_to_gui(0);
var _my = device_mouse_y_to_gui(0);

#region //Draw test window
for (var _i = 0; _i < ques_count; _i++) {
	
	var _x = ques_txt_x;
	var _y_ques = _i*(ques_txt_buff)+ques_txt_y+ti_txt_y;
	var _y_box = _y_ques + tf_box_buff_y;
	
	draw_text(ques_txt_x, _y_ques, questions[_i][0]);
	
	switch questions[_i][1] {
		case "bool":
			draw_rectangle(_x + tf_box_buff_x, _y_box, _x + tf_box_buff_x + tf_box_size, _y_box + tf_box_size, 1);
			draw_rectangle(_x + (2*tf_box_buff_x), _y_box, _x + (2*tf_box_buff_x) + tf_box_size, _y_box + tf_box_size, 1);
			draw_text(_x + tf_box_buff_x + tf_box_size + 20, _y_box - tf_box_size, "True");
			draw_text(_x + (2*tf_box_buff_x) + tf_box_size + 20, _y_box - tf_box_size, "False");
		break;
		
		case "mc":
			for (var _ii = 0; _ii < 3; _ii++) {
				draw_text(_x + (_ii*mc_buff_x), _y_ques + mc_buff_y, string("{0}:", _ii+1));
			};
		break;
		
		case "oe":
			var _line_x = _x + oe_buff_x;
			var _line_y = _y_ques + oe_buff_y;
			draw_line_width(_line_x, _line_y, _line_x + oe_line_len, _line_y, 7);
			
			draw_set_color(c_grey);
			draw_set_alpha(oe_inp_alpha);
			draw_rectangle(_line_x, _line_y-oe_inp_hei, _line_x + oe_line_len, _line_y, 0);
			draw_set_color(c_white);
			draw_set_alpha(0.75);
			
			if writing {
				oe_inp_alpha = 0.25;
				var _input = string_copy(keyboard_string, 1, 40);
				draw_text(_line_x, _line_y-oe_inp_hei, _input);
			} else { oe_inp_alpha = 0.75 };
			
			if !point_in_rectangle(_mx, _my, _line_x, _line_y-oe_inp_hei, _line_x + oe_line_len, _line_y) {
				if mouse_check_button_pressed(mb_left) { writing = 0 };
			};
			
			if point_in_rectangle(_mx, _my, _line_x, _line_y-oe_inp_hei, _line_x + oe_line_len, _line_y) {
				oe_inp_alpha = 0.25;
				if mouse_check_button_pressed(mb_left) {
					keyboard_string = "";
					writing = 1;	
				};
			};
			draw_set_alpha(1);
		break;
	};
};
#endregion

#region //Draw evidence window
for (var _iii = 0; _iii < array_length(evidence); _iii++) {
	var _spr = asset_get_index(evidence[_iii][2]);
	var _spr_wid = sprite_get_width(_spr);
	var _spr_hei = sprite_get_height(_spr);
	
	draw_sprite(_spr, 0, evi_x, evi_y + (_iii*evi_buff_y))
	
	var _col_x = evi_x-(_spr_wid/2);
	var _col_y = evi_y - (_spr_hei/2) + (_iii*evi_buff_y);
	evi_name_x = (wnd_e_x-(wnd_e_wid/2))-(string_width(evidence[_iii][1])/2);
	
	draw_set_color(c_white);
	if point_in_rectangle(_mx, _my, _col_x, _col_y, _col_x + _spr_wid, _col_y + _spr_hei) {
		draw_text(evi_name_x, evi_name_y, evidence[_iii][1]);
	};
};
#endregion