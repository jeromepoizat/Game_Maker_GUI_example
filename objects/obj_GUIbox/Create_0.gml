//TODO: move this
global.gui_x = window_get_width();
global.gui_y = window_get_height();
global.gui_scale = 1;

sprite_box = spr_sprite1;
size_x = 300;
size_y = 60;
size_x_min = 50;
size_y_min = 50;
size_x_max = 800;
size_y_max = 800;
txt = "SOMETHING to write here or something to not Write here, up to you to decide";
hoover_err = 5; // amount of error in pixel accepted for hoover state
fit_txt_height = true;
fit_txt_width = false;

//actions:
writable = false;
clickable = false;
movable = false;
resizable = true;
//states:
hoovered = false;
clicked = false;
selected = false;
moving = false;
resizing = false;

click_timer = 0;
click_x = 0;
click_y = 0;
//state sub-images id
sub_idle = 0;
sub_hoover = 1;
sub_click = 2;
sub_selected = 3;
sub_hoover_selected = 4;
//
txt_border_x_len = 50;
txt_border_y_len = 50;
resize_border_len = 25; //length of resize border in pixel
resizing_left = false;
resizing_right = false;
resizing_top = false;
resizing_bottom = false;
hoover_resizing_left = false;
hoover_resizing_right = false;
hoover_resizing_top = false;
hoover_resizing_bottom = false;
//draw variables
real_size_x = size_x*global.gui_scale;
real_size_y = size_y*global.gui_scale;
draw_scale_x = real_size_x/sprite_get_width(sprite_box);
draw_scale_y = real_size_y/sprite_get_height(sprite_box);
draw_sub = sub_idle;
draw_alpha = 1;
draw_x = x;
draw_y = y;

function box_fit_txt(){
	if fit_txt_height == true {
		var _txt_height = string_height_ext(txt, -1, real_size_x - txt_border_x_len*2);
		if _txt_height > size_y - txt_border_y_len*2 {
			size_y = _txt_height + txt_border_y_len*2;
		}
		
		while(size_y - txt_border_y_len*2 > _txt_height){
			size_y -= 1;
		}
	}

	if fit_txt_width == true {
		var _txt_width = string_width(txt);
		if _txt_width > size_x - txt_border_x_len*2 {
			size_x = _txt_width + txt_border_x_len*2;
		}
	}	
}