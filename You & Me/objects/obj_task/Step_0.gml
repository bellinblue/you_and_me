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
		if _rm_check == room_get_name(room) { _rm_check = 1; }
	} else if _rm_check == "none" { _rm_check = 1; }
		
	_active = array_contains(tasks_active, tasks[_i]);
			
	if _prereq_res && _rm_check && !_is_completed && !_active {
		array_push(tasks_active, tasks[_i]);
	};
	
};

for (var _y = 0; _y < array_length(tasks_active); _y++) {
	if last_clicked == tasks_active[_y][2] {
		for (var _z = 0; _z < array_length(tasks); _z++) {
			if tasks[_z][3] == tasks_active[_y][3] {
				tasks[_z][4] = 1;
				array_delete(tasks_active, _y, 1);
				break;
			}
		}
	};
};

	



