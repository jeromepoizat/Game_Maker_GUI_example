//TODO: txt option for digits only + 3 digit seperator

visible = false;
alarm[0]=1;
owner_relative_x = "left";
owner_relative_y = "top";
owner_resize_x = false;
owner_resize_y = false;
relative_x = 50;
relative_y = 50;
owner = noone;
owner_center_x = false;
owner_center_y = false;
sprite_box =  spr_sprite1;
size_x = 300;
size_y = 60;
size_x_min = 120;
size_y_min = 120;
size_x_max = 1000;
size_y_max = 1000;
txt = "SOMETHING to write here or something to not Write here, up to you to decide";
border_x_len = 10;
border_y_len = 6;
hoover_err = 5; // amount of error in pixel accepted for hoover state
fit_txt_height = true; //will strecth size_y to fit text
fit_txt_width = false; //will strecth size_x to fit text
fitdown_txt_height = false; //will fit window height to minimum size_y
//animation
animation_state = 1; //0: close, 1: open
animation_origin_type = "self";
animation_origin_offset_x = "left";
animation_origin_offset_y = "top"; 
animation_origin_x_relative = 0;
animation_origin_y_relative = 0;
animation_origin_x_real = 0;
animation_origin_y_real = 0;
animation_origin_scale = 1;
animation_progress = 0; //0 - 1
animation_origin_alpha = 0;
animation_lerp_rate = 0.08;
animation_scale = 1;
animation_alpha = 1;

//actions: edit here
writable = false;
clickable = false;
selectable = false;
movable = false;
resizable = false;
//states: all default to false, do not edit here
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
sub_click = 3;
sub_selected = 3;
sub_hoover_selected = 3;
//
resize_border = 25; //length of resize border in pixel
resizing_left = false;
resizing_right = false;
resizing_top = false;
resizing_bottom = false;
hoover_resizing_left = false;
hoover_resizing_right = false;
hoover_resizing_top = false;
hoover_resizing_bottom = false;
//txtbox variables
cursor_index = 0; //selected ? string_length(txt) : 0;
highlight_index = 0;
str_to_cursor = "";
str_to_highlight = "";
hold_arrow_left = 0;
hold_arrow_right = 0;
hold_backspace = 0;
cursor_blink_rate = 0;
draw_cursor = true;
txt_font = fnt_default
cursor_x = 0;

clip_surface = -1;
clip_width = 0;
clip_height = 0;
clip_x = 0;
clip_y = 0;
x_offset = 0;

valid_drag = false;
double_click_timer_full = 30;
double_click_timer = 0;
double_click = false;

txt_font = fnt_default;
txt_color = c_white;
cursor_color = c_aqua;
highlight_color = c_dkgray;

// set macros for command keys on Mac
#macro VK_RCOMMAND 91
#macro VK_LCOMMAND 92

old_owner_size_x = 0;
old_owner_size_y = 0;
	
//draw variables
old_scale = global.gui_scale;
real_size_x = size_x*global.gui_scale;
real_size_y = size_y*global.gui_scale;
real_relative_x = relative_x*global.gui_scale;
real_relative_y = relative_y*global.gui_scale;

txt_border_x_len = border_x_len*global.gui_scale;
txt_border_y_len = border_y_len*global.gui_scale;
txt_x = txt_border_x_len;
txt_y = txt_border_y_len;
resize_border_len = resize_border*global.gui_scale;

draw_scale_x = real_size_x/sprite_get_width(sprite_box);
draw_scale_y = real_size_y/sprite_get_height(sprite_box);
draw_sub = sub_idle;
draw_alpha = 1;
draw_x = x;
draw_y = y;

function box_fit_txt(){
	if fit_txt_height == true {
		draw_set_font(txt_font);
		var _txt_height = string_height_ext(txt, -1, size_x - border_x_len*2);
		if _txt_height == 0 {
			_txt_height = string_height("A");
		}
		if _txt_height > size_y - border_y_len*2 {
			size_y = _txt_height + border_y_len*2;
		}
		
		if fitdown_txt_height == true {
			size_y = _txt_height + 18/global.gui_scale + border_y_len;
		}
		
		if size_y > size_y_max {
			size_y = size_y_max;
		}
		
		if size_y < size_y_min {
			size_y = size_y_min;
		}

	}

	if fit_txt_width == true {
		draw_set_font(txt_font);
		var _txt_width = string_width(txt);
		if _txt_width > size_x - border_x_len*2 {
			size_x = _txt_width + border_x_len*2;
		}
		
		if size_x > size_x_max {
			size_x = size_x_max;
		}
		
		if size_x < size_x_min {
			size_x = size_x_min;
		}
	}	
}