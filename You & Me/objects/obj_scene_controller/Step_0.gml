while _read_it_rmch < array_length(collision_data_rmch) {
	if array_length(collision_data_rmch[_read_it_rmch]) == 1 {
		if _has_read_rmch { _read_it_rmch = array_length(collision_data_rmch); break };
		if collision_data_rmch[_read_it_rmch][0] == rm_cur+"_"+view_cur { 
			_reading_rmch = 1;
			_has_read_rmch = 1;
			_read_it_rmch++;	
		} else { _reading_rmch = 0 };
	};
	
	if _reading_rmch {
		array_push(collision_draw_rmch, collision_data_rmch[_read_it_rmch]);
	};
	
	_read_it_rmch++;
};

while _read_it_items < array_length(collision_data_items) {
	if array_length(collision_data_items[_read_it_items]) == 1 {
		if _has_read_items { _read_it_items = array_length(collision_data_items); break };
		if collision_data_items[_read_it_items][0] == rm_cur+"_"+view_cur { 
			_reading_items = 1;
			_has_read_items = 1;
			_read_it_items++;	
		} else { _reading_items = 0 };
	};
	
	if _reading_items {
		array_push(collision_draw_items, collision_data_items[_read_it_items]);
	};
	
	_read_it_items++;
};

if !instance_exists(obj_title){	
	if !_loaded_it_rmch {
		for (var _i = 0; _i < array_length(collision_draw_rmch); _i++) {
			var _rm_tar = collision_draw_rmch[_i][0];
			var _coll_x = collision_draw_rmch[_i][1];
			var _coll_y = collision_draw_rmch[_i][2];
			var _coll_sx = collision_draw_rmch[_i][3];
			var _coll_sy = collision_draw_rmch[_i][4];
			var _coll_ori = collision_draw_rmch[_i][5];
			var _coll_ind = collision_draw_rmch[_i][6];
			var _to_spawn = collision_draw_rmch[_i][7];
			var _coll_res = 2;
		
			switch _to_spawn {
				case 0: _to_spawn = obj_collision_arrow; break;
				case 1: _to_spawn = obj_collision_circle; break;
				case 2: _to_spawn = obj_collision_square; break;
			};		
		
			with instance_create_layer(_coll_x, _coll_y, "Instances_vis", _to_spawn) {
				image_xscale = _coll_sx;
				image_yscale = _coll_sy;
				image_angle = _coll_ori;
				item_name = string("to_{0}", _rm_tar);
				item_name_display = _coll_ind;
				result = _coll_res;
				room_target = _rm_tar;
			};
		};
		
		_loaded_it_rmch = 1;
	
	};
	
	
	if !_loaded_it_items {
		for (var _i = 0; _i < array_length(collision_draw_items); _i++) {
			var _item_name = collision_draw_items[_i][0];
			var _coll_x = collision_draw_items[_i][1];
			var _coll_y = collision_draw_items[_i][2];
			var _coll_sx = collision_draw_items[_i][3];
			var _coll_sy = collision_draw_items[_i][4];
			var _coll_ori = collision_draw_items[_i][5];
			var _coll_ind = collision_draw_items[_i][6];
			var _coll_res = collision_draw_items[_i][7];
			var _to_spawn = collision_draw_items[_i][8];
		
			switch _to_spawn {
				case 0: _to_spawn = obj_collision_arrow; break;
				case 1: _to_spawn = obj_collision_circle; break;
				case 2: _to_spawn = obj_collision_square; break;
			};		
		
			with instance_create_layer(_coll_x, _coll_y, "Instances_vis", _to_spawn) {
				image_xscale = _coll_sx;
				image_yscale = _coll_sy;
				image_angle = _coll_ori;
				item_name = _item_name;
				item_name_display = _coll_ind;
				result = _coll_res;
			};
		};
		
		_loaded_it_items = 1;
	
	};
};

if array_length(rmch) > 0 { event_user(0) };