draw_rectangle_color(0, 0, room_width, room_height, c_grey, c_grey, c_grey, c_grey, 0);
draw_sprite(wnd_t_spr, 0, wnd_t_x, wnd_t_y);
draw_sprite(wnd_e_spr, 0, wnd_e_x, wnd_e_y);

draw_set_color(c_black);

draw_set_halign(fa_center);
draw_text_transformed(ti_txt_x, ti_txt_y, ques_string, 0.75, 0.75, 0);
draw_set_halign(fa_left);

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
			draw_line_width(_x+oe_buff_x, _y_ques + oe_buff_y, _x + oe_line_len + oe_buff_x, _y_ques + oe_buff_y, 7);

		break;
	};
};
#endregion

#region //Draw evidence window
for (var _iii = 0; _iii < array_length(evidence); _iii++) {
	draw_sprite(evidence[_iii][2])
};
#endregion

draw_set_color(c_white);