draw_rectangle_color(0, 0, room_width, room_height, c_black, c_black, c_black, c_black, 0);
draw_sprite(window_sprite, -1, window_x, window_y);

if root == 6 || root == 7 { tile_scale = 0.275 - (0.025*root); }
else { tile_scale = 0.4-(0.05*root); }

tile_width = sprite_get_width(tile_sprite)*tile_scale;
tile_height = sprite_get_height(tile_sprite)*tile_scale;
tile_margin_inner = 15;
tile_margin_outer = ((window_width-(tile_width*root))/2)-((tile_margin_inner*(root-1))/2);
tile_x = (window_x-(window_width/2)) + tile_margin_outer;
tile_y = (window_y-(window_height/2)) + tile_margin_outer;
array_resize(active_tiles, array_length(words_display));

var _mx = device_mouse_x_to_gui(0);
var _my = device_mouse_y_to_gui(0);


for (var _a = 0; _a < array_length(active_tiles); _a++) { 
	if active_tiles[_a] = 1 { 
		if !array_contains(compare, words_display[_a]) { array_push(compare, words_display[_a]) };
		
	} else {
		if array_contains(compare, words_display[_a]) {
			var _rem = array_get_index(compare, words_display[_a])
			array_delete(compare, _rem, 1);
		};
	}
};

var _i = 0;
for (var _r = 0; _r < root; _r++) {
	for (var _c = 0; _c < root; _c++) {
		var _x = tile_x+(_c*(tile_width+tile_margin_inner))
		var _y = tile_y+(_r*(tile_height+tile_margin_inner))
		
			if point_in_rectangle(_mx, _my, _x, _y, _x+tile_width, _y+tile_height) {
				tile_alpha = 0.5;
					if mouse_check_button_pressed(mb_left) { 
						if !is_clickable && active_tiles[_i] == 1 {
							active_tiles[_i] = 0;
						} else if is_clickable { active_tiles[_i] = !active_tiles[_i] };
					};
			} else { tile_alpha = 1 };

		if active_tiles[_i] = 1 { 
			draw_sprite_ext(tile_sprite, -1, _x, _y, tile_scale, tile_scale, 0, c_red, tile_alpha-0.2);
		} else {
			draw_sprite_ext(tile_sprite, -1, _x, _y, tile_scale, tile_scale, 0, c_white, tile_alpha);
		}
		var _col = c_black;
		var _scale = 0.75;
		var _tile_txt_x = (_x + (tile_width/2 - (string_width(words_display[_i])*_scale)/2));
		var _tile_txt_y = _y + (tile_height - (string_height(words_display[_i])*_scale))/2;
		draw_text_transformed_color(_tile_txt_x, _tile_txt_y, words_display[_i], _scale, _scale, 0, _col, _col, _col, _col, 1);
	
		_i++;
	};
};

draw_text_transformed(1470, 100, "Select similar words", 0.75, 0.75, 0);

if array_length(compare) >= root*2 {
	is_clickable = 0;
	var _txt_x = 60;
	draw_text_transformed(_txt_x, 100, "Hit enter to check", 0.75, 0.75, 0);
	if keyboard_check_pressed(vk_enter) {
		if array_contains_ext(compare, words[0], 1) { res = 1 } else { res = 0; }
	};

	if res == 0 { draw_text_transformed(_txt_x, 300, "These aren't\nthe correct answers!", 0.75, 0.75, 0) } 
	else if res == 1 { 
		draw_text_transformed(_txt_x, 300, "These are the\ncorrect answers", 0.75, 0.75, 0) 
		draw_text_transformed(_txt_x, 500, string("The theme\nwas: {0}", theme), 0.75, 0.75, 0)
	};

} else { is_clickable = 1; res = -1 };