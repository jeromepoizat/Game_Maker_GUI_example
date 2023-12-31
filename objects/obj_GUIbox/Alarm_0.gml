visible = true;

var _owner_x;
var _owner_y;
var _owner_size_x;
var _owner_size_y

if owner == noone {
	//window
	_owner_x = 0;
	_owner_y = 0;
	_owner_size_x = global.gui_x;
	_owner_size_y = global.gui_y;
	old_owner_size_x = global.gui_x;
	old_owner_size_y = global.gui_y;
}
else
{
	_owner_x = owner.x;
	_owner_y = owner.y;
	old_owner_size_x = owner.size_x;
	old_owner_size_y = owner.size_y;	
	_owner_size_x = owner.real_size_x;
	_owner_size_y = owner.real_size_y;	
}

if owner_relative_x == "left" {
	x = _owner_x + real_relative_x;
}
else 
if owner_relative_x == "right" {
	x = _owner_x + _owner_size_x - real_relative_x - real_size_x;
}

if owner_relative_y == "top" {
	y = _owner_y + real_relative_y;
}
else 
if owner_relative_y == "bottom" {
	y = _owner_y + _owner_size_y - real_relative_y - real_size_y;
}

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


if writable {
	alarm[1] = cursor_blink_rate;
}