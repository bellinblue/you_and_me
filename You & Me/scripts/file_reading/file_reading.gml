function file_read_all_text(_filename) { //Returns a string of all document text
    if (!file_exists(_filename)) { return undefined };
	var _file = file_text_open_read(_filename);
	var _result = "";
	var _line_count = 0;
	var _ret = [];

	while !file_text_eof(_file) {
		_result += file_text_read_string(_file);
		_result += "\n";
		_line_count++;
		file_text_readln(_file);
	};
		
	file_text_close(_file);
	
	_ret = [_result, _line_count];
	return _ret;
}

function file_count_flags(_directory, _item_name) { //Counts number of dialogue flags, returns integer
	var _file = file_text_open_read(_directory);
	var _line_count = file_read_all_text(_directory)[1];
	var _block = 0;
	var _flag_count = 0;
					
	for (var _i = 0; _i < _line_count; _i++) {
		var _res = file_text_readln(_file)
											
		if string_count(string("{0}END", _item_name), _res) == 1 { _block = 0; _i = _line_count; }
						
		if _block {
			if string_count("~", _res) { _flag_count++ };	
		}
						
		if string_count(_item_name, _res) == 1 { _block = 1; }

	}
					
	_block = 0;
	file_text_close(_file);
	return _flag_count
	
}

function file_feed_string(_directory, _flag, _item_name, _is_dialogue) { //Sends file strings to dialogue box object
		var _file = file_text_open_read(_directory);
		var _line_count = file_read_all_text(_directory)[1];
		var _c = 0;
		var _block_prep = 0;
		var _block = 0;
		var _read = 0;
		var _send = [];
		var _flag_count = 0;
		var _sprite_string;
		var _sprite;	
		var _name;
					
		for (var _i = 0; _i < _line_count; _i++) {
			var _res = file_text_readln(_file)
			var _end_found = string_count(string("{0}END", _item_name), _res);
			var _flag_end_found = string_count(string("~{0}", _flag+1), _res);
			var _flag_beg_found = string_count(string("~{0}", _flag), _res);
			var _item_found = string_count(_item_name, _res);
			var _item_end_found = string_count(string("{0}END", _item_name), _res);
			var _loc_true = string_count(string("~{0}", obj_scene_controller.loc_cur), _res)
			var _rm_true = string_count(string("~{0}", obj_scene_controller.rm_cur), _res)
			var _view_true = string_count(string("~{0}", obj_scene_controller.view_cur), _res)
			var _loc_end = string_count(string("~{0}END", obj_scene_controller.loc_cur), _res)
			var _rm_end = string_count(string("~{0}END", obj_scene_controller.rm_cur), _res)
			var _view_end = string_count(string("~{0}END", obj_scene_controller.view_cur), _res)
			
			if _loc_true { _block_prep++ };
			if _rm_true { _block_prep++ };
			if _view_true { _block_prep++ };
			
			if _loc_end || _rm_end || _view_end { _block_prep-- };
			
			if _end_found { _block = 0; _block_prep = 0; _i = _line_count; }
						
			if _block {

				if _flag_end_found { _read = 0; _i = _line_count; } 
				
				if _read {
					_res = string_replace_all(_res, "\\n", "\n");
					_res = string_trim_start(_res);
					_send[_c] = _res;
					_c++;
				};
				
				if _flag_beg_found { 
					_read = 1; 
					_res = string_replace_all(_res, "\\n", "\n");
					_res = string_trim(_res);
					_sprite_string = string_split(_res, ",");
					if _is_dialogue { 
						_sprite = asset_get_index(_sprite_string[1]);
						_name = _sprite_string[2];
					};
					if !_is_dialogue { 
						_name = _sprite_string[1];	
					};
				};	
			};			
			if _item_found && _block_prep == 3 { _block = 1 };
		};
				
	_block_prep = 3;
	_block = 0;
	file_text_close(_file);	
	
	if _is_dialogue {
		with instance_create_layer(0, 0, "Instances_inv", obj_dialoguebox) {
			sprite_img = _sprite;
			char_name = _name;
			for (var _i = 0; _i < array_length(_send); _i++) {
				text[_i] = _send[_i];
			};
		};
	} else {
		with instance_create_layer(0, 0, "Instances_inv", obj_messages) {
			for (var _i = 0; _i < array_length(_send); _i++) {
				array_push(contacts[_name][0], _send[_i]);
			};
		};
		if !instance_exists(obj_messages){ instance_create_layer(-1, -1, "Instances_inv", obj_messages) };
	};
};

function task_list_init() { //Reads task list files and sends to task object
	var _dir = string("inventory_data_local\\tasks\\{0}\\{1}.txt", obj_master.persp, string("day_{0}", obj_master.day));
	var _file = file_text_open_read(_dir);
	var _line_count = file_read_all_text(_dir)[1];
	var _parts = [];
	
	for (var _i = 0; _i < _line_count; _i++) {
		var _res = file_text_readln(_file);
		_parts[_i] = string_split(_res, ",");
	};


	file_text_close(_file);	
	return _parts;
};

function file_read_block_day(_dir) {
	var _file = file_text_open_read(_dir);
	var _line_count = file_read_all_text(_dir)[1];
	var _block = 0;
	var _info = [];
	
	for (var _i = 0; _i < _line_count; _i++) {
		var _res = file_text_readln(_file)
		
		if string_count(string("~{0}", obj_master.day+1), _res) == 1 { _block = 0; _i = _line_count; }
							
		if _block {
			_res = string_replace_all(_res, "\\n", "\n")
			array_push(_info, _res);
		}
						
		if string_count(string("~{0}", obj_master.day), _res) == 1 { _block = 1; }
		
	};
	
	_block = 0;
	file_text_close(_file);
	
	return _info;
};

function puzzle_word() { //Reads daily puzzle file, sends to object
	var _info = file_read_block_day(string("words\\words.txt"))
	
	_info[2] = string_split(_info[2], ",");
	_info[3] = string_split(_info[3], ",");
	_info[0] = int64(_info[0]);
	
	with instance_create_layer(0, 0, "Instances_inv", obj_puzzle_word) { 
		root = _info[0];
		theme = _info[1];
		words[0] = _info[2];
		words[1] = _info[3];
		words_display = array_shuffle(array_concat(words[0], words[1]))
	}
	
	_info = [];
	
};

function load_evidence(){
	var _info = file_read_block_day("inventory_data_local\\evidence\\evidence.txt")
	
	for (var _ii = 0; _ii < array_length(_info); _ii++) {
		_info[_ii] = string_split(_info[_ii], ",");
	}
	
	return _info;
	
};

function puzzle_evidence() {
	var _info = file_read_block_day("questions\\questions.txt");
	
	_info[1] = int64(_info[1]);
	var _temp = [];
	for (var _ii = 2; _ii < (2+_info[1]); _ii++) {
		_info[_ii] = string_split(_info[_ii], ",");
		array_push(_temp, _info[_ii]);
	}
	
	with instance_create_layer(0, 0, "Instances_inv", obj_puzzle_evidence) { 
		ques_string = _info[0];
		ques_count = _info[1];
		questions = _temp;
	
		for (var _iii = 0; _iii < array_length(questions); _iii++) {
			
			var _fin = array_get_index(questions[_iii], array_last(questions[_iii]));
			var _repl = string_replace(questions[_iii][_fin], "\r\n", "");	
			questions[_iii][_fin] = _repl;
		};
	
		for (var _i = 0; _i < ques_count; _i++) {
			answers[_i][0] = undefined;
			answers[_i][1] = undefined;
		};
	}
	
	_info = [];
	
};

function load_gall_mus(_dir){
	var _file = file_text_open_read(_dir);
	var _line_count = file_read_all_text(_dir)[1];
	var _info = [];
	
	for (var _i = 0; _i < _line_count; _i++) {
		var _res = file_text_readln(_file)
		_res = string_replace_all(_res, "\\n", "\n")
		array_push(_info, _res);	
	};
	
	for (var _ii = 0; _ii < array_length(_info); _ii++) {
		_info[_ii] = string_split(_info[_ii], ",");
		_info[_ii][3] = int64(_info[_ii][3]);
	};

	file_text_close(_file);
	return _info;
	
};

function replace_file_value(_filename, _line_id, _to_replace, _value){
	var _file = file_text_open_read(_filename);
	var _read = file_read_all_text( _filename); 
	
	var _cont = string_split(_read[0], "\n"); var _len = _read[1];
	array_pop(_cont);

	for (var _i = 0; _i < _len-1; _i++) {
		if string_count(_line_id, _cont[_i]) {
			var _split = string_split(_cont[_i], ",");
			_split[_to_replace] = _value;
			var _to_add = "";
			for (var _ii = 0; _ii < array_length(_split); _ii++) {
				_to_add += string("{0},", _split[_ii]);		
			};
			_to_add = string_delete(_to_add, string_length(_to_add), 1);
			_cont[_i] = _to_add;
			
			break;	
		}
	};
	
	file_text_close(_file);

	_file = file_text_open_write(_filename)
	
	for (var _iii = 0; _iii < array_length(_cont); _iii++) {
		file_text_write_string(_file, _cont[_iii]);
		if _iii != array_length(_cont)-1 { file_text_writeln(_file) };
	};	
	
	file_text_close(_file);
	
};

function get_contacts_data(){
	var _dir = "inventory_data_local\\contacts.txt";
	var _file = file_text_open_read(_dir);
	var _line_count = file_read_all_text(_dir)[1];
	var _info = [];
	
	for (var _i = 0; _i < _line_count; _i++) {
		var _res = file_text_readln(_file)
		_res = string_trim_end(_res)
		array_push(_info, _res);
	};
	
	
	for (var _ii = 0; _ii < array_length(_info); _ii++) { 
		_info[_ii] = string_split(_info[_ii],",") 
		for (var _intinn = 0; _intinn < array_length(_info[_ii]); _intinn++) {
			if (string_digits(_info[_ii][_intinn]) == string(_info[_ii][_intinn])) {
				_info[_ii][_intinn] = int64(_info[_ii][_intinn]) 
			};
		};
	};
		
	return _info
	
};

function get_scene_data(_day){
	var _dir = "scenes.txt";
	var _file = file_text_open_read(_dir);
	var _line_count = file_read_all_text(_dir)[1];
	var _info = [];
	var _feed = "";
	var _block = 0;
	
	for (var _i = 0; _i < _line_count; _i++) {
		var _res = file_text_readln(_file)
		
		if string_count(string("~{0}", obj_master.day+1), _res) == 1 { _block = 0; _i = _line_count; }
							
		if _block {
			_res = string_trim_end(_res)
			array_push(_info, _res);
		}
						
		if string_count(string("~{0}", obj_master.day), _res) == 1 { _block = 1; }
		
	};
	
	_block = 0;
	
	file_text_close(_file);
	
	for (var _ii = 0; _ii < array_length(_info); _ii++) {
		if string_count(",", _info[_ii]) > 1 {
			_info[_ii] = string_split(_info[_ii], ",")
		
			var _len = array_length(_info[_ii])-1;
			if _len > 1 {
				_info[_ii][_len] = int64(_info[_ii][_len]);	
			};
		} else { _feed = _info[_ii]; array_delete(_info, _ii, 1); _ii-- };
		
	};
	
	var _send = [_info, _feed];
	return _send
	
};

function get_collision_data(_location, _type){
	var _type_string = "";
	if _type == 0 { _type_string = "room_change" }
	else if _type == 1 { _type_string = "items" };
	
	var _dirs = (string("collision_data_default\\{0}\\{1}.txt", _type_string, _location));
	
		var _file = file_text_open_read(_dirs);
		var _line_count = file_read_all_text(_dirs)[1];
		var _info = [];
		var _block = 0;
		var _captured = "";
	
		for (var _ii = 0; _ii < _line_count; _ii++) {
			var _res = file_text_readln(_file)
		
			if string_count("~", _res) == 1 && _captured != _res { _block = 0; _captured = "" };
							
			if _block {
				_res = string_trim_end(_res);
				array_push(_info, _res);
			}
						
			if string_count("~", _res) == 1 && _captured == "" { 
				_block = 1; _captured = _res;
				_res = string_delete(_res,0,1); 
				_info[_ii] = string_delete(_res,string_length(_res)-1,2);
			};
		};
	
		_block = 0;
		file_text_close(_file);

		for (var _iii = 0; _iii < array_length(_info); _iii++) { 
			
			_info[_iii] = string_split(_info[_iii],",") 
			for (var _intinn = 0; _intinn < array_length(_info[_iii]); _intinn++) {
				if (string_digits(_info[_iii][_intinn]) == string(_info[_iii][_intinn])) {
					_info[_iii][_intinn] = int64(_info[_iii][_intinn]) 
				};
			};
		};
	
		return _info
	
};
