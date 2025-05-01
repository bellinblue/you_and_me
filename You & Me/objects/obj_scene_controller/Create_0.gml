scene_data = get_scene_data(obj_master.day); 

loc_cur = scene_data[0][0][2];
rm_cur = scene_data[0][0][3];
view_cur = scene_data[0][0][4];
is_freeroam = scene_data[0][0][5];

collision_data_rmch = get_collision_data("rm_"+loc_cur, 0);
collision_draw_rmch = [];
collision_data_items = get_collision_data("rm_"+loc_cur, 1);
collision_draw_items = [];

rmch = [];

_reading_rmch = 0;
_read_it_rmch = 0;
_loaded_it_rmch = 0;
_has_read_rmch = 0;
_reading_items = 0;
_read_it_items = 0;
_loaded_it_items = 0;
_has_read_items = 0;

bkgr_cur = asset_get_index(string("bkgr_"+rm_cur+"_"+view_cur));
