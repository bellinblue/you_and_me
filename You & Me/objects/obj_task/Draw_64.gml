if obj_master.task_access {
	
	if keyboard_check_pressed(ord("T")){ hidden = !hidden; }
	
	var _base = room_width;

	if !hidden { window_x = _base; } 
		else { window_x = _base + window_width + window_margin - tab_margin; }
		
	draw_sprite(spr_task, window_index, window_x, window_y);

	for (var _i = 0; _i < array_length(tasks_active); _i++) {
		draw_set_color(c_black)
		draw_text(window_x - window_width + text_margin, window_y, string("- {0}", tasks_active[_i][3]))	
		draw_set_color(c_white)
	};
	
};