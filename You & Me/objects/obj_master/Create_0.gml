window_set_size(960, 540);
game_font = fnt_debug;
draw_set_font(game_font);

if !directory_exists("extracted\\") {
	var _ext = zip_unzip("inventory_data.zip", game_save_id + "extracted\\");
}

text_speed = 1;
max_text_speed = 5;
menu_access = 1;
task_access = 1;
coll_access = 1;

puzzle_evidence_completed = 0;
puzzle_word_completed = 0;

controllers = [];
gallery = load_gall_mus("extracted\\gallery.txt");
gallery_available = [];
for (var _i = 0; _i < array_length(gallery); _i++) {
	if gallery[_i][3] == 1 {
		array_push(gallery_available, gallery[_i]);	
	}
};
//music = load_gall_mus("music");

day = 0;
persp = "elijah";

instance_create_layer(0, 0, "Instances_inv", obj_task);

depth = 0;