if keyboard_check_pressed(vk_escape) {
	obj_master.menu_access = 0;
	instance_create_layer(-1, -1, "Instances_inv", obj_menu_phone);
	instance_destroy();	
};