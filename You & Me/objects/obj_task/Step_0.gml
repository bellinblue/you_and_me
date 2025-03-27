for (var _i = 0; _i < array_length(tasks); _i++) {
	var _prereq_check = tasks[_i][0];
	var _prereq_res = 0;
	var _rm_check = tasks[_i][1];
	var _rm_res = 0;
	var _is_completed = tasks[_i][4];
	var _active = 0;
	
	if _prereq_check != "none" {
		for (var _n = 0; _n < array_length(tasks); _n++) {
			if tasks[_n][3] == _prereq_check && tasks[_n][4] == 1 {
				_prereq_res = 1;
			}
		}
	} else if _prereq_check == "none" { _prereq_res = 1 }	
	
	if _rm_check != "none" {
		if _rm_check == room_get_name(room) { _rm_check = 1 }; //Room checking
	} else if _rm_check == "none" { _rm_check = 1 };
		
	_active = array_contains(tasks_active, tasks[_i]);
			
	if _prereq_res && _rm_check && !_is_completed && !_active {
		array_push(tasks_active, tasks[_i]);
	};
	
};

for (var _y = 0; _y < array_length(tasks_active); _y++) {
	var _puzzle_req = string_digits(tasks_active[_y][2]);
	var _tar_id = -1;
	var _dialogue = [];
	var _flag_req = -1;
	var _flag_met = 0;
	if string_count("-dialogue", tasks_active[_y][2]) > 0 {
		_dialogue = string_split(tasks_active[_y][2], "-");
		_flag_req = string_digits(_dialogue[1]);
		for (var _i = 0; _i < array_length(obj_master.controllers); _i++) {
			if obj_master.controllers[_i][1] == _dialogue[0] { 
				_tar_id = obj_master.controllers[_i][0];
				
				if _tar_id.flag >= _flag_req { _flag_met = 1 };
			};
		};
	};

	if last_clicked == tasks_active[_y][2] ||
	   (string_count("puzzle_word", tasks_active[_y][2]) > 0 && 
	   obj_master.puzzle_word_completed >= _puzzle_req ) ||
	   (string_count("puzzle_evidence", tasks_active[_y][2]) > 0 && 
	   obj_master.puzzle_evidence_completed >= _puzzle_req ) ||
	   _flag_met

	{
		for (var _z = 0; _z < array_length(tasks); _z++) {
			if tasks[_z][3] == tasks_active[_y][3] {
				tasks[_z][4] = 1;
				array_delete(tasks_active, _y, 1);
				break;
			}
		}
	};
};

	



