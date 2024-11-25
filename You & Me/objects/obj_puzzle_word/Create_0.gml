root = 0;
theme = "";
words = [];
words_display = [];

window_sprite = spr_puzzle_word_back;
window_x = room_width/2;
window_y = room_height/2;
window_width = sprite_get_width(window_sprite);
window_height = sprite_get_height(window_sprite);

tile_sprite = spr_puzzle_word_tile;
tile_scale = 0;
tile_width = 0;
tile_height = 0;
tile_margin_inner = 0;
tile_margin_outer = 0;
tile_x = 0;
tile_y = 0;
tile_alpha = 1;
active_tiles = [];
compare = [];
is_clickable = 1;
res = -1;

depth = -999;




