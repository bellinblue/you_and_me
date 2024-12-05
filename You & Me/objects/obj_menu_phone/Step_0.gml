if keyboard_check_pressed(vk_escape) && !_is_active && _is_interactable { 
		obj_master.menu_access = 1;
		if instance_exists(obj_collision) { obj_master.coll_access = 1 };
		instance_destroy();
	};