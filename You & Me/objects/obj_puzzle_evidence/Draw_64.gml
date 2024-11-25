draw_sprite(wnd_t_spr, 0, wnd_t_x, wnd_t_y);
draw_sprite(wnd_e_spr, 0, wnd_e_x, wnd_e_y);

draw_set_color(c_black);

draw_set_halign(fa_center);
draw_text_transformed(ti_txt_x, ti_txt_y, ques_string, 0.75, 0.75, 0);
draw_set_halign(fa_left);

for (var _i = 0; _i < ques_count; _i++) {
	
	var _x = ques_txt_x + tf_box_buff_y;
	var _y_ques = _i*(ques_txt_buff)+ques_txt_y+ti_txt_y;
	var _y_box = _y_ques + tf_box_buff_y;
	
	draw_text(ques_txt_x, _y_ques, questions[_i][0]);
	
	switch questions[_i][1] {
		case "bool":

			draw_rectangle(_x, _y_box, _x + tf_box_size, _y_box + tf_box_size, 1);
			draw_rectangle(_x + tf_box_buff_x, _y_box, _x + tf_box_buff_x + tf_box_size, _y_box + tf_box_size, 1);
			draw_text(_x + tf_box_size + 20, _y_box - tf_box_size/2, "True");
			draw_text(_x + tf_box_size + 20 + tf_box_buff_x, _y_box - tf_box_size/2, "False");
			
		break;
		
		case "mc":
			draw_text(_x + tf_box_size + 20, _y_box - tf_box_size/2, "True");
		
		break;
		
		case "oe":
		break;
	};
};

draw_set_color(c_white);