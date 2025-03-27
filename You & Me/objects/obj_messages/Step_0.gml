if string_length(targ) > 0 {
	array_push(contacts[contact], targ);
	targ = "";
}

obj_master.task_access = 0;

if keyboard_check_pressed(vk_escape) {
	instance_destroy();
};