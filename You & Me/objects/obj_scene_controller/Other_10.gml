var _len = array_length(rmch)-1;
rm_cur = rmch[_len-1];
view_cur = rmch[_len];
if array_length(rmch) == 3 { loc_cur = rmch[0] };

collision_data_rmch = get_collision_data_rmch("rm_"+loc_cur);
collision_draw_rmch = [];
_reading = 0;
_read_it = 0;
_loaded_it = 0;
_has_read = 0;

bkgr_cur = asset_get_index(string("bkgr_"+rm_cur+"_"+view_cur));
rmch = [];