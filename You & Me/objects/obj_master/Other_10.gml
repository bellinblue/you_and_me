gallery = [];
gallery_available = [];
gallery = load_gall_mus("gallery");
for (var _i = 0; _i < array_length(gallery); _i++) {
	if gallery[_i][3] == 1 {
		array_push(gallery_available, gallery[_i]);	
	}
};