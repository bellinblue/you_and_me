if instance_exists(obj_parent_windows) {
	coll_access = 0;
	task_access = 0;
	if instance_exists(obj_settings) || instance_exists(obj_title) { 
		menu_access = 0;
		if instance_exists(obj_menu_phone) { instance_destroy(obj_menu_phone) };	
	} else if !instance_exists(obj_menu_phone) { menu_access = 1 };
} else { coll_access = 1; task_access = 1; menu_access = 1 };

if keyboard_check_pressed(vk_f4) { 
	if (window_get_fullscreen() == 1) {
		if instance_exists(obj_settings) {
			obj_settings.visuals[1][1] = 0;
		} else { window_set_fullscreen(0) };
	} else if (window_get_fullscreen() == 0) { 
		if instance_exists(obj_settings) {
			obj_settings.visuals[1][1] = 1; 
		} else { 
			window_set_fullscreen(1) 
		};
	};
};

if instance_exists(obj_settings) {
	if obj_settings.visuals[1][1] { window_set_fullscreen(1) }
	else if !obj_settings.visuals[1][1] { window_set_fullscreen(0) };
};

if menu_access {
	if keyboard_check_pressed(vk_escape) {
		if instance_exists(obj_puzzle_evidence){
			if !obj_puzzle_evidence._evi_check {
				menu_access = 0;
				instance_create_layer(-1, -1, "Instances_inv", obj_menu_phone);	
			};
		} else {
			menu_access = 0;
			instance_create_layer(-1, -1, "Instances_inv", obj_menu_phone);	
		};
	};
};

//DEBUG
draw_set_font(fnt_debug);
draw_text_color(30, room_height-100, string(room_get_name(room)), c_white, c_white, c_white, c_white, 0.5);

if room == rm_debug {
	
	if !instance_exists(obj_puzzle_word) && !instance_exists(obj_puzzle_evidence) {
	
		if keyboard_check_pressed(ord("W")) {
			puzzle_word();
		};

		if keyboard_check_pressed(ord("E")) {
			puzzle_evidence();
		};
	};
};