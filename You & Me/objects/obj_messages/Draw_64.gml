var _mx = device_mouse_x_to_gui(0);
var _my = device_mouse_y_to_gui(0);

#region //Window design init
var _spr_panel;
var _panel_width;
var _panel_height;
var _panel_x;
var _panel_y;
var _spr_b;
var _spr_t;
var _window_width;
var _window_height;
var _window_x;
var _window_y;
#endregion

#region //Message bubble design init
var _mess_spr;
var _mess_x;
var _mess_y;
var _mess_y_buff;
var _mess_wid;
var _mess_hei;
var _mess_mar;
var _mess_ori;
var _mess_color;
var _mess_t_mar;
var _mess_text_x;
var _mess_text_y;
var _mess_len;

var _mess_scr;
var _mess_max;
var _mess_min;
var _wnd_slice;
var _mess_gap;
#endregion

#region //Contact icon design init
var _conta_spr;
var _conta_x;
var _conta_y;
var _conta_y_buff;
var _conta_wid;
var _conta_hei;
var _conta_mar;
var _conta_alpha;
var _conta_t_mar;
var _conta_text_x;
var _conta_text_y;
var _conta_len;

var _conta_scr;
var _conta_max;
var _conta_min;
#endregion


if _is_computer {
	_spr_panel = spr_window_compmsg_back_panel
	_panel_width = sprite_get_width(_spr_panel);
	_panel_height = sprite_get_height(_spr_panel);
	_panel_x = 49; //Dependant on top sprite rim width
	_panel_y = 62; //Dependant on top sprite rim height
	_spr_b = spr_window_compmsg_back;
	_spr_t = spr_window_compmsg_top;
	_window_width = 0;
	_window_height = 0;
	_window_x = 0;
	_window_y = 0;
	
	draw_sprite(_spr_b, -1, _window_x, _window_y);
	
	#region //Messages
	_mess_spr = spr_message_window_comp;
	_mess_y_buff = 50;
	_mess_wid = sprite_get_width(_mess_spr);
	_mess_hei = sprite_get_height(_mess_spr);
	_mess_mar = 80;
	_mess_t_mar = 80;
	_mess_len = array_length(contacts[contact][0])

	_mess_scr = 75;
	_mess_gap = 100 + _panel_y;
	_wnd_slice = (sprite_get_height(_spr_b) - _panel_y - _mess_gap);
	_mess_max = 0; //Gap between top of screen and first message
	_mess_min = _wnd_slice - (_mess_len*(_mess_hei + _mess_y_buff)); 
	//Gap between bottom of screen and last message
	
	if _mess_len > 0 {
		for (var _i = 0; _i < _mess_len; _i++){
			_mess_y = _mess_gap + (_i*(_mess_y_buff+_mess_hei)) + window_message_y;
			_mess_text_y = _mess_t_mar + _mess_y;
			if ((_i % 2 == 0) || _i == 0 ) { 
				_mess_x = room_width - _mess_mar - _mess_wid; _mess_ori = 1; _mess_color = c_white;
				_mess_text_x = _mess_x + _mess_t_mar;
			} else {
				_mess_x = room_width - _mess_mar; _mess_ori = -1; _mess_color = c_lime;
				_mess_text_x = _mess_x - _mess_wid + _mess_t_mar;
			};
	
			draw_sprite_ext(_mess_spr, -1, _mess_x, _mess_y, _mess_ori, 1, 0, _mess_color, 1);
			draw_text(_mess_text_x, _mess_text_y, contacts[contact][0][_i]);		
		};
	} else {
		draw_text(room_width*(2/6), _panel_y + 50, "No Messages Yet");
	};
	#endregion
	#region //Contacts
	_conta_spr = spr_window_contact_comp;
	_conta_x = 70;
	_conta_y_buff = 50;
	_conta_wid = sprite_get_width(_conta_spr);
	_conta_hei = sprite_get_height(_conta_spr);
	_conta_mar = 0;
	_conta_alpha = 1;
	_conta_t_mar = 0;
	_conta_len = array_length(contacts)

	_conta_scr = 100;
	_conta_max = _conta_len;
	_conta_min = -(_conta_len + _conta_hei);

	draw_sprite(_spr_panel, -1, _panel_x, _panel_y);

	if point_in_rectangle(_mx, _my, _panel_x, _panel_y, _panel_x+_panel_width, _panel_y+_panel_height) {
		if _conta_len > 0 {
			if mouse_wheel_up() {
				if contact_message_y < _conta_max { contact_message_y+=_conta_scr };
			};
			if mouse_wheel_down() {
				if contact_message_y > _conta_min { contact_message_y-=_conta_scr };	
			};
		};
	} else {
		if _mess_len > 0 {
			if mouse_wheel_up() {
				if window_message_y < _mess_max { window_message_y+=_mess_scr };
			};
			if mouse_wheel_down() {
				if window_message_y > _mess_min { window_message_y-=_mess_scr };	
			};	
		};
	};
	
	contacts[contact][4] = window_message_y;
	
	for (var _ii = 0; _ii < _conta_len; _ii++){
		if contacts[_ii][3] = 1 {
			_conta_y = (_ii*(_conta_y_buff+_conta_hei)) + contact_message_y;
			_conta_text_y = _conta_t_mar + _conta_y;
			_conta_text_x = _conta_wid/2-35;
		
			if point_in_rectangle(_mx, _my, _conta_x, _conta_y, _conta_x+_conta_wid, _conta_y+_conta_hei) {
				_conta_alpha = 0.5;
				if mouse_check_button(mb_left) {
					for (var _iii = 0; _iii < array_length(contacts); _iii++) { contacts[_iii][2] = 0 };
					contacts[_ii][2] = 1;
					contact = _ii;
					window_message_y = contacts[contact][4];
				};
		
			} else if contacts[_ii][2] = 1 { _conta_alpha = 0.5 } else { _conta_alpha = 1 };
	
			draw_sprite_ext(_conta_spr, -1, _conta_x, _conta_y, 1, 1, 0, c_white, _conta_alpha);
			draw_text(_conta_text_x, _conta_text_y, contacts[_ii][1]);
		};
	};

	#endregion
	
	draw_sprite(_spr_t, -1, _window_x, _window_y);
	
} 
else {

	_spr_panel = spr_window_phonemsg_back_panel
	_panel_width = sprite_get_width(_spr_panel);
	_panel_height = sprite_get_height(_spr_panel);
	_panel_x = 49; //Dependant on top sprite rim width
	_panel_y = 62; //Dependant on top sprite rim height
	_spr_b = spr_window_phonemsg_back;
	_spr_t = spr_window_phonemsg_top;
	_window_width = 0;
	_window_height = 0;
	_window_x = 0;
	_window_y = 0;

	draw_sprite(_spr_b, -1, _window_x, _window_y);
	
	#region //Messages
	_mess_spr = spr_message_window_phone;
	_mess_y_buff = 50;
	_mess_wid = sprite_get_width(_mess_spr);
	_mess_hei = sprite_get_height(_mess_spr);
	_mess_mar = 500;
	_mess_t_mar = 80;
	_mess_len = array_length(contacts[contact][0])
	
	_mess_scr = 75; //Scrolling speed
	_mess_gap = 50 + _panel_y; //Initial gap between top of screen and first message
	_wnd_slice = (sprite_get_height(_spr_b) - _mess_gap);
	_mess_max = 0; //Scroll max gap between top of screen and first message
	_mess_min = _wnd_slice - (_mess_len*(_mess_hei + _mess_y_buff)); 
	//Scroll min gap between bottom of screen and last message
	
	if _mess_len > 0 {
		for (var _i = 0; _i < _mess_len; _i++){
			_mess_y = _mess_gap + (_i*(_mess_y_buff+_mess_hei)) + window_message_y;
			_mess_text_y = _mess_t_mar + _mess_y;
			if ((_i % 2 == 0) || _i == 0 ) { 
				_mess_x = room_width*(2/6); _mess_ori = 1; _mess_color = c_white;
				_mess_text_x = _mess_x + _mess_t_mar;
			} else {
				_mess_x = room_width - _mess_mar; _mess_ori = -1; _mess_color = c_lime;
				_mess_text_x = _mess_x - _mess_wid + _mess_t_mar;
			};
	
			draw_sprite_ext(_mess_spr, -1, _mess_x, _mess_y, _mess_ori, 1, 0, _mess_color, 1);
			draw_text(_mess_text_x, _mess_text_y, contacts[contact][0][_i]);
		} 
	} else {
		draw_text(room_width*(2/6), _panel_y + 50, "No Messages Yet");
	};
	#endregion
	#region //Contacts
	_conta_spr = spr_window_contact_phone;
	_conta_x = 365;
	_conta_y_buff = 50;
	_conta_wid = sprite_get_width(_conta_spr);
	_conta_hei = sprite_get_height(_conta_spr);
	_conta_mar = 0;
	_conta_alpha = 1;
	_conta_t_mar = 0;
	_conta_len = array_length(contacts)

	_conta_scr = 100;
	_conta_max = _conta_len;
	_conta_min = -(_conta_len + _conta_hei);

	draw_sprite(_spr_panel, -1, _panel_x, _panel_y);

	if point_in_rectangle(_mx, _my, _panel_x, _panel_y, _panel_x+_panel_width, _panel_y+_panel_height) {
		if _conta_len > 0 {
			if mouse_wheel_up() {
				if contact_message_y < _conta_max { contact_message_y+=_conta_scr };
			};
			if mouse_wheel_down() {
				if contact_message_y > _conta_min { contact_message_y-=_conta_scr };	
			};
		};
	} else {
		if _mess_len > 0 {
			if mouse_wheel_up() {
				if window_message_y < _mess_max { window_message_y+=_mess_scr };
			};
			if mouse_wheel_down() {
				if window_message_y > _mess_min { window_message_y-=_mess_scr };	
			};	
		};
	};
	
	contacts[contact][4] = window_message_y;
	
	for (var _ii = 0; _ii < _conta_len; _ii++){
		if contacts[_ii][3] = 1 {
			_conta_y = (_ii*(_conta_y_buff+_conta_hei)) + contact_message_y;
			_conta_text_y = _conta_t_mar + _conta_y;
			_conta_text_x = _conta_wid/2-35;
		
			if point_in_rectangle(_mx, _my, _conta_x, _conta_y, _conta_x+_conta_wid, _conta_y+_conta_hei) {
				_conta_alpha = 0.5;
				if mouse_check_button(mb_left) {
					for (var _iii = 0; _iii < array_length(contacts); _iii++) { contacts[_iii][2] = 0 };
					contacts[_ii][2] = 1;
					contact = _ii;
					window_message_y = contacts[contact][4];
				};
		
			} else if contacts[_ii][2] = 1 { _conta_alpha = 0.5 } else { _conta_alpha = 1 };
	
			draw_sprite_ext(_conta_spr, -1, _conta_x, _conta_y, 1, 1, 0, c_white, _conta_alpha);
		};
	};

	#endregion
	
	draw_sprite(_spr_t, -1, _window_x, _window_y);
	
};

