if room == rm_debug {
	draw_text(100, 100, "Press 'W' to test the word puzzle.\n\nPress 'E' to test the evidence puzzle.\n\nPress 'Esc' to access the phone.")
	//draw_text_transformed(1290, 330, "Press 'T' to toggle the task tab.", 0.75, 0.75, 0);
};


if keyboard_check_pressed(ord("H")) {
	replace_file_value("extracted\\gallery.txt","gall_photo_2",3,1)
};	