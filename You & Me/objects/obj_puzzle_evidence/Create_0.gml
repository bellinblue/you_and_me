ques_string = "";
ques_count = 0;
questions = [];
evidence = load_evidence();

wnd_t_spr = spr_puzzle_evidence_test_back;
wnd_t_wid = sprite_get_width(wnd_t_spr);
wnd_t_hei = sprite_get_height(wnd_t_spr);
wnd_t_x = wnd_t_wid/2;
wnd_t_y = room_height/2;

wnd_e_spr = spr_puzzle_evidence_inven_back;
wnd_e_wid = sprite_get_width(wnd_e_spr);
wnd_e_hei = sprite_get_height(wnd_e_spr);
wnd_e_x = room_width;
wnd_e_y = 0;

ti_txt_x = wnd_t_x+(wnd_t_wid/2);
ti_txt_y = wnd_t_y - (wnd_t_hei/2) + 30;

ques_txt_x = wnd_t_x + 30;
ques_txt_y = wnd_t_y - (wnd_t_hei/2) + 30;
ques_txt_buff = 200;

tf_box_buff_x = 200;
tf_box_buff_y = font_get_size(obj_master.game_font) + 80;
tf_box_size = 30;