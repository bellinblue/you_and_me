if evi_alpha >= 1 || evi_alpha <= 0 { evi_dir = !evi_dir };

var _it = 0.1;
if evi_dir == 1 {
	evi_alpha += _it;	
} else if evi_dir == 0 {
	evi_alpha -= _it;
};
