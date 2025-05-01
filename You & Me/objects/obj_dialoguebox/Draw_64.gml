var _window_x = room_width / 2;
var _window_y = room_height - window_height - 50;
var _next = keyboard_check_pressed(vk_space);

page_count = array_length(text);

if !init {
	
	draw_set_font(font);
	draw_set_valign(fa_top);
	draw_set_halign(fa_left);
	
	var _line_break_pos = []; _line_break_pos[0, page_count] = 1;
	var _line_break_num = []; _line_break_num[page_count] = 0;
	var _line_break_offset = []; _line_break_offset[page_count] = 0;
	var _snd = []; _snd[page_count] = noone;
	var _last_free_space = 0;
	
	for (var _i = 0; _i < page_count; _i++) {
		
		text_len[_i] = string_length(text[_i]);

		for (var _c = 0; _c < text_len[_i]; _c++) {
			
			var _char_pos = _c+1;
			char[_c, _i] = string_char_at(text[_i], _char_pos);
			var _text_to_char = string_copy(text[_i], 1, _char_pos);
			var _text_cur_width = string_width(_text_to_char) - string_width(char[_c, _i]);
			
			if char[_c, _i] == " " { _last_free_space = _char_pos+1 };
			
			if _text_cur_width - _line_break_offset[_i] > line_width {
				
				_line_break_pos[_line_break_num[_i], _i] = _last_free_space;
				_line_break_num[_i]++;
				var _text_last_space = string_copy(text[_i], 1, _last_free_space);
				var _last_free_space_string = string_char_at(text[_i], _last_free_space);
				_line_break_offset[_i] = string_width(_text_last_space) - string_width(_last_free_space_string);
				
			};
			
		};
		
		for (var _c = 0; _c < text_len[_i]; _c++) {
			var _char_pos = _c+1;
			var _text_x = _window_x - window_width/2 + text_margin;
			var _text_y = _window_y + text_margin;
			var _text_to_char = string_copy(text[_i], 1, _char_pos);
			var _text_cur_width = string_width(_text_to_char) - string_width(char[_c, _i]);
			var _text_line = 0;
			
			for (var _lb = 0; _lb < _line_break_num[_i]; _lb++) {
			
				if _char_pos >= _line_break_pos[_lb, _i] {
						
					var _str_copy = string_copy(text[_i], _line_break_pos[_lb, _i], _char_pos - _line_break_pos[_lb, _i]);
					_text_cur_width = string_width(_str_copy);
					_text_line = _lb+1;
				};
			};
			char_x[_c, _i] = _text_x + _text_cur_width;
			char_y[_c, _i] = _text_y + _text_line*line_sep;
		};
	};
	init = 1;
};
	
if text_pause_timer <= 0 {
	if draw_char < text_len[page]-2 {
		draw_char += text_speed;
		draw_char = clamp(draw_char, 0, text_len[page]);
	
		var _check_char = string_char_at(text[page], draw_char);
		if _check_char == "." || _check_char == "?" || _check_char == "," {
			text_pause_timer = text_pause_time;
		} else { 
			if snd_count < snd_delay { 
				snd_count++;
			} else { snd_count = 0; audio_play_sound(snd_debug, 5, false); } 
		};
	};
} else { text_pause_timer-- };

if _next {
	if draw_char == text_len[page]-2 {
		if page < page_count-1 {
			page++;
			draw_char = 0;
		} else { instance_destroy() };
	} else { draw_char = text_len[page]-2 };
};

if sprite_img != -1 { draw_sprite(sprite_img, -1, sprite_x, sprite_y) };

window_index += window_anim_speed;
draw_sprite(window_sprite, window_index, _window_x, _window_y);
draw_set_alpha(0.6);
draw_rectangle_color(_window_x - window_width/2, _window_y - 100, _window_x - window_width/2 + 400, _window_y - 10, c_black, c_black, c_black, c_black, 0);
draw_set_alpha(1);
draw_text(_window_x - window_width/2 + text_margin, _window_y - 100, char_name);

for (var _c = 0; _c < draw_char; _c++) {
	draw_text(char_x[_c, page], char_y[_c, page], char[_c, page]);	
};
