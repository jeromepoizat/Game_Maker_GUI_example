visible = true;

//draw variables
old_scale = global.gui_scale;
real_size_x = size_x*global.gui_scale;
real_size_y = size_y*global.gui_scale;
real_relative_x = relative_x*global.gui_scale;
real_relative_y = relative_y*global.gui_scale;

txt_border_x_len = border_x_len*(global.gui_scale+max(-0.2,global.gui_scale-1));
txt_border_y_len = border_y_len*(global.gui_scale+max(-0.2,global.gui_scale-1));
txt_x = txt_border_x_len;
txt_y = txt_border_y_len;
resize_border_len = resize_border*global.gui_scale;

draw_scale_x = real_size_x/sprite_get_width(sprite_box);
draw_scale_y = real_size_y/sprite_get_height(sprite_box);
draw_sub = sub_idle;
draw_alpha = 1;
draw_x = x;
draw_y = y;

if writable {
	alarm[1] = cursor_blink_rate;
}