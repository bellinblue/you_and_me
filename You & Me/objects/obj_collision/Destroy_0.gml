for (var _i = 0; _i < array_length(obj_master.controllers); _i++) {
	if obj_master.controllers[_i][0] == id {
		array_delete(obj_master.controllers, _i, 1);
	}
};