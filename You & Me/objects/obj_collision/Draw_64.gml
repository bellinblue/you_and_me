var _mx = device_mouse_x_to_gui(0);
var _my = device_mouse_y_to_gui(0);
var _left = 60;
var _right = string_width(item_name_display) + _left;
var _pmargin_x = 0;
var _pmargin_y = 110;


var _zone = view_wport-(view_wport/4);

if obj_master.coll_access {
	
	if position_meeting(_mx, _my, self) {
		
		if _mx > _zone { _pmargin_x = -_right } else { _pmargin_x = _left };
		
		draw_rectangle_color(_mx + _pmargin_x - 20,  _my - _pmargin_y - 10, _mx + _pmargin_x + string_width(item_name_display) + 20 , _my - 20,
		c_black, c_black, c_black, c_black, false)
		
		draw_text_color(_mx + _pmargin_x,  _my - _pmargin_y, item_name_display, c_white, c_white, c_white, c_white, 1);

		if mouse_check_button_pressed(mb_left) {
			obj_master.coll_access = 0;
			if instance_exists(obj_task) { obj_task.last_clicked = item_name };
		
			switch result {
				case 0:
					if !instance_exists(obj_dialoguebox){			
						var _dir = string("textfeeder\\{0}.txt", room_get_name(room))
						flag_max = file_count_flags(_dir, item_name);
						if flag >= flag_max { flag = flag_max-1 }
						file_feed_string(_dir, flag, item_name, 1);
						flag++;
					}
				break;
				case 1:
					if !instance_exists(obj_messagebox){			
						var _dir = string("textfeeder\\{0}.txt", room_get_name(room))
						flag_max = file_count_flags(_dir, item_name);
						if flag >= flag_max { flag = flag_max-1 }
						file_feed_string(_dir, flag, item_name, 0);
						flag++;
					}
				break;
				case 2:
					room_goto(room_target);
					if instance_exists(obj_task) { obj_task.last_clicked = item_name };
					obj_master.coll_access = 1;
				break;
			}
		}
	}
}
