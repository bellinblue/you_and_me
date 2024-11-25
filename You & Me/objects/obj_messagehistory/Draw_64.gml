var _spr = spr_message_window;
var _x = 0;
var _y = 0
var _y_buff = 50;
var _wid = sprite_get_width(_spr);
var _hei = sprite_get_height(_spr);
var _mar = 100;
var _ori = 1;
var _t_mar = 100;
var _text_x = 0;
var _text_y = 0;
var _len = array_length(contacts[contact])

var _scr = 50;
var _max = 100;
var _min = -(((_len-3)*(_y_buff+_hei)) + _max);

if _len > 0 {
	if mouse_wheel_up() {
		if window_y < _max { window_y+=_scr };
	};
	if mouse_wheel_down() {
		if window_y > _min { window_y-=_scr };	
	};
	
	for (var _i = 0; _i < _len; _i++){
		_y = (_i*(_y_buff+_hei)) + window_y;
		_text_y = _t_mar + _y;
		if ((_i % 2 == 0) || _i == 0 ) { _x = (2*_mar)+(_wid/2); _ori = 1; } 
		else { _x = room_width/2; _ori = -1 };
		_text_x = _x - _wid/2 + _t_mar;
	
		draw_sprite_ext(_spr, -1, _x, _y, _ori, 1, 0, c_white, 1);
		draw_text(_text_x, _text_y, contacts[contact][_i]);
		
	};
};