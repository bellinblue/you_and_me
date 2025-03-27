//function string_count_lines(_str) { //Counts all "\n"s and "\r"s in a string, returns integer
//    var _newlines_count = string_count("\r", _str) + string_count("\n", _str) - string_count("\r\n", _str);
	
//    var _last_char = string_char_at(_str, string_length(_str));
//    var _is_last_newline = _last_char == "\r" || _last_char == "\n";

//    return _newlines_count - (_is_last_newline ? 1 : 0) + 1;
//}

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
		var _block = 0;
		var _read = 0;
		var _send = [];
		var _flag_count = 0;
		var _sprite_string;
		var _sprite;
					
		for (var _i = 0; _i < _line_count; _i++) {
			var _res = file_text_readln(_file)
											
			if string_count(string("{0}END", _item_name), _res) == 1 { _block = 0; _i = _line_count; }
						
			if _block {

				if string_count(string("~{0}", _flag+1), _res) == 1 { _read = 0; _i = _line_count; } 
				
				if _read {
					_res = string_replace_all(_res, "\\n", "\n");
					_send[_c] = _res;
					_c++;
				};
				
				if string_count(string("~{0}", _flag), _res) == 1 { 
					_read = 1; 
					_res = string_replace_all(_res, "\\n", "\n");
					_sprite_string = string_copy(_res, 4, string_length(_res)-5);
					_sprite = asset_get_index(_sprite_string);
				};	
			};			
			if string_count(_item_name, _res) == 1 { _block = 1 };
		};
					
	_block = 0;
	file_text_close(_file);	
	
	if _is_dialogue {
		with instance_create_layer(0, 0, "Instances_inv", obj_dialoguebox) {
			sprite_img = _sprite;
			for (var _i = 0; _i < array_length(_send); _i++) {
				text[_i] = _send[_i];
			};
		};
	} else {
		with instance_create_layer(0, 0, "Instances_inv", obj_messagebox) {
			sprite_img = _sprite;
			contact = "elijah";
			for (var _i = 0; _i < array_length(_send); _i++) {
				text[_i] = _send[_i];
			};
		};
		if !instance_exists(obj_messages){ instance_create_layer(-1, -1, "Instances_inv", obj_messages) };
	};
};

function task_list_init() { //Reads task list files and sends to task object
	var _dir = string("tasks\\{0}\\{1}.txt", obj_master.persp, string("day_{0}", obj_master.day));
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
	var _info = file_read_block_day(string("evidence\\evidence.txt"))
	
	for (var _ii = 0; _ii < array_length(_info); _ii++) {
		_info[_ii] = string_split(_info[_ii], ",");
	}
	
	return _info;
	
};

function puzzle_evidence() {
	var _info = file_read_block_day(string("questions\\questions.txt"))
	
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

function replace_file_value(_directory, _filename, _line_id, _to_replace, _value){
	var _file;
	if _directory == -1 {
		_file = file_text_open_read(string("{0}.txt", _filename));
	} else { _file = file_text_open_read(string("{0}\\{1}.txt", _directory, _filename)) };
	var _read = file_read_all_text(string("{0}.txt", _filename))[0]; 
	var _cont = string_split(_read[0], "\n"); var _len = _read[1];
	
	print(_cont)
	
	for (var _i = 0; _i < _len; _i++) {
		
	};
	
};

function get_scene_data(_room){
	
	
};
