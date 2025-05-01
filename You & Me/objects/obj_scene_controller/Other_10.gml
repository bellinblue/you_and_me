var _len = array_length(rmch)-1;
rm_cur = rmch[_len-1];
view_cur = rmch[_len];
if array_length(rmch) == 3 { loc_cur = rmch[0] };

collision_data_rmch = get_collision_data("rm_"+loc_cur, 0);
collision_draw_rmch = [];
collision_data_items = get_collision_data("rm_"+loc_cur, 1);
collision_draw_items = [];

_reading_rmch = 0;
_read_it_rmch = 0;
_loaded_it_rmch = 0;
_has_read_rmch = 0;
_reading_items = 0;
_read_it_items = 0;
_loaded_it_items = 0;
_has_read_items = 0;

bkgr_cur = asset_get_index(string("bkgr_"+rm_cur+"_"+view_cur));
rmch = [];