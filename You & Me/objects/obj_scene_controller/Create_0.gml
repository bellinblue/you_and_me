scene_data = get_scene_data(obj_master.day); 

loc_cur = scene_data[0][0][2];
rm_cur = scene_data[0][0][3];
view_cur = scene_data[0][0][4];
is_freeroam = scene_data[0][0][5];

collision_data_rmch = get_collision_data_rmch("rm_"+loc_cur);
collision_draw_rmch = [];
_reading = 0;
_read_it = 0;
_loaded_it = 0;
_has_read = 0;

bkgr_cur = asset_get_index(string("bkgr_"+rm_cur+"_"+view_cur));
rmch = [];