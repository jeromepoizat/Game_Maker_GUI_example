if visible == false {exit;}

var _mouse_gui_x = device_mouse_x_to_gui(0);
var _mouse_gui_y = device_mouse_y_to_gui(0);

//get owner variables
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
}
else
{
	_owner_x = owner.x;
	_owner_y = owner.y;
	_owner_size_x = owner.real_size_x;
	_owner_size_y = owner.real_size_y;	
	
	//if resize with owner: change size
	
	if owner_resize_x {
		if old_owner_size_x != owner.size_x {
			size_x = size_x*(owner.size_x/old_owner_size_x);
			old_owner_size_x = owner.size_x;
		}
	}
	if owner_resize_y {
		if old_owner_size_y != owner.size_y {
			size_y = size_y*(owner.size_y/old_owner_size_y);
			old_owner_size_y = owner.size_y;
		}	
	}
}

real_size_x = size_x*global.gui_scale;
real_size_y = size_y*global.gui_scale;

//update real_relative_x/y if not moving and not resized
if !moving && (resizing_left + resizing_right + resizing_top + resizing_bottom) == 0 {
	if instance_exists(owner){
		real_relative_x = relative_x*global.gui_scale;
		real_relative_y = relative_y*global.gui_scale;
	}
	else
	{
		real_relative_x = relative_x;
		real_relative_y = relative_y;		
	}
} 
else //if moving or resized
{
	//no change in scale => moving => change relative_x/y
	if old_scale == global.gui_scale {
		if instance_exists(owner){
			relative_x = real_relative_x/global.gui_scale;
			relative_y = real_relative_y/global.gui_scale;
		}
		else
		{
			relative_x = real_relative_x;
			relative_y = real_relative_y;			
		}
	}
	else //change of scale => change real_relative_x
	{
		if instance_exists(owner){
			real_relative_x = relative_x*global.gui_scale;
			real_relative_y = relative_y*global.gui_scale;	
		}
		else
		{
			real_relative_x = relative_x;
			real_relative_y = relative_y;			
		}
		old_scale = global.gui_scale;
	}
}

//set x and y
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

//keep object in ui borders
if clamp_inside_owner {
	if x < _owner_x {
		x = _owner_x;
	}
	if x + real_size_x > _owner_x + _owner_size_x {
		x = _owner_x + _owner_size_x - real_size_x;
	}
	if y < _owner_y {
		y = _owner_y;
	}
	if y + real_size_y > _owner_y + _owner_size_y {
		y = _owner_y + _owner_size_y - real_size_y;
	}
}

box_fit_txt()

if writable {
	scr_textbox_step();	
}

if moving {
	//clicked = true;
	x = x + (_mouse_gui_x - click_x);
	y = y + (_mouse_gui_y - click_y);
	click_x = _mouse_gui_x;
	click_y = _mouse_gui_y;
}
else
if resizable {
	if ( resizing_left || resizing_right || resizing_top || resizing_bottom )
	{
		
		var _old_size_x = size_x;
		var _old_size_y = size_y;

		if resizing_left {		
			if ((_mouse_gui_x - click_x) > 0 && _mouse_gui_x > x + hoover_err)
			|| ((_mouse_gui_x - click_x) < 0 && _mouse_gui_x < x - hoover_err){
				size_x = size_x - (_mouse_gui_x - click_x)/global.gui_scale;
				
				if size_x < size_x_min {
					size_x = size_x_min;
				}	
				else
				if size_x > size_x_max {
					size_x = size_x_max;	
				}
				
				box_fit_txt();
				
				x = x - (size_x - _old_size_x)*global.gui_scale;
				
				if x < _owner_x && clamp_inside_owner { 
					size_x = size_x + x/global.gui_scale;
					x = _owner_x;
				}
			}
		}

		if resizing_right {
			if ((_mouse_gui_x - click_x) > 0 && _mouse_gui_x > x + real_size_x + hoover_err)
			|| ((_mouse_gui_x - click_x) < 0 && _mouse_gui_x < x + real_size_x - hoover_err){			
				size_x = size_x + (_mouse_gui_x - click_x)/global.gui_scale;
				
				if size_x < size_x_min {
					size_x = size_x_min;
				}	
				else
				if size_x > size_x_max {
					size_x = size_x_max;
				}
				
				box_fit_txt();
				
				if x + size_x*global.gui_scale > _owner_size_x && clamp_inside_owner {
					size_x = (_owner_size_x - x)/global.gui_scale;
				}
			}
		}

		if resizing_top {
			if ((_mouse_gui_y - click_y) > 0 && _mouse_gui_y > y + hoover_err)
			|| ((_mouse_gui_y - click_y) < 0 && _mouse_gui_y < y - hoover_err){
				size_y = size_y - (_mouse_gui_y - click_y)/global.gui_scale;
				
				if size_y < size_y_min {
					size_y = size_y_min;
				}	
				else
				if size_y > size_y_max {
					size_y = size_y_max;	
				}	
				
				box_fit_txt();

				y = y - (size_y - _old_size_y)*global.gui_scale;
				
				if y < _owner_x && clamp_inside_owner { 
					size_y = size_y + y/global.gui_scale;
					y = _owner_x;
				}
			}	
		}

		if resizing_bottom {
			if ((_mouse_gui_y - click_y) > 0 && _mouse_gui_y > y + real_size_y + hoover_err)
			|| ((_mouse_gui_y - click_y) < 0 && _mouse_gui_y < y + real_size_y - hoover_err){			
				size_y = size_y + (_mouse_gui_y - click_y)/global.gui_scale;
				
				if size_y < size_y_min {
					size_y = size_y_min;
				}	
				else
				if size_y > size_y_max {
					size_y = size_y_max;
				}
				
				box_fit_txt();
				
				if y + size_y*global.gui_scale > _owner_size_y && clamp_inside_owner {
					size_y = (_owner_size_y - y)/global.gui_scale;
				}
			}			
		}
	
	click_x = _mouse_gui_x;
	click_y = _mouse_gui_y;	
	
	}
	
}

//set sub-image
if clickable && ((hoovered && clicked) || moving) {
	draw_sub = sub_click;	
} else 
if hoovered && selected {
	draw_sub = sub_hoover_selected;	
} else
if hoovered {
	draw_sub = sub_hoover;
} else
if selected {
	draw_sub = sub_selected;	
} else {
	draw_sub = sub_idle;		
}

//tmp (sub for resizing)
if resizing_left || resizing_right || resizing_top || resizing_bottom  {
 draw_sub = sub_hoover_selected;		
}

//refresh variables
real_size_x = size_x*global.gui_scale;
real_size_y = size_y*global.gui_scale;

//correct x,y
if owner_center_x == true {
	x = _owner_x + _owner_size_x/2 - real_size_x/2;	
}

if owner_center_y == true {
	y = _owner_y + _owner_size_y/2 - real_size_y/2;	
}

//keep object in ui borders
if clamp_inside_owner {
	if x < _owner_x {
		x = _owner_x;
	}
	if x + real_size_x > _owner_x + _owner_size_x {
		x = _owner_x + _owner_size_x - real_size_x;
	}
	if y < _owner_y {
		y = _owner_y;
	}
	if y + real_size_y > _owner_y + _owner_size_y {
		y = _owner_y + _owner_size_y - real_size_y;
	}
}

if owner_relative_x == "left" {
	real_relative_x = x - _owner_x;
}
else 
if owner_relative_x == "right" {
	real_relative_x = _owner_x + _owner_size_x - real_size_x - x ;
}

if owner_relative_y == "top" {
	real_relative_y = y - _owner_y;
}
else 
if owner_relative_y == "bottom" {
	real_relative_y = _owner_y + _owner_size_y - real_size_y - y ;
}

txt_border_x_len = border_x_len*global.gui_scale;
txt_border_y_len = border_y_len*global.gui_scale;
txt_x = txt_border_x_len;
txt_y = txt_border_y_len;


//animation

if animation_state == 0 {//close
	if animation_progress > 0 {
		animation_progress = lerp(animation_progress,0, animation_lerp_rate);
	}
}
else
if animation_state == 1 {//open
	if animation_progress < 1 {
		animation_progress = lerp(animation_progress, 1, animation_lerp_rate);
	}
}


//animation
if animation_origin_type == "self" || !instance_exists(owner){
	if instance_exists(owner){
		animation_origin_x_real = x + animation_origin_x_relative*global.gui_scale;
		animation_origin_y_real = y + animation_origin_y_relative*global.gui_scale;		
	}
	else
	{
		animation_origin_x_real = x + animation_origin_x_relative;
		animation_origin_y_real = y + animation_origin_y_relative;
	}
}
else
if animation_origin_type == "owner" {
	animation_origin_x_real = owner.animation_origin_x_real + animation_origin_x_relative;
	animation_origin_y_real = owner.animation_origin_y_real + animation_origin_y_relative;
}


if instance_exists(owner) && (owner.animation_progress < 0.999) {
	
	animation_progress = owner.animation_progress;
	
	//animation_origin_x_real = x + owner.animation_origin_x_relative;
	//animation_origin_y_real = y + owner.animation_origin_y_relative;
	
	animation_origin_x_real = x - owner.x + owner.animation_origin_x_real
	animation_origin_y_real = y - owner.y + owner.animation_origin_y_real
	
}

if instance_exists(owner) && (owner.animation_scale < 0.999) {
	animation_origin_x_real = owner.animation_origin_x_real + animation_origin_x_relative;
	animation_origin_y_real = owner.animation_origin_y_real + animation_origin_y_relative;
}

animation_alpha = lerp(animation_origin_alpha, 1, sqr(animation_progress));
if instance_exists(owner) && (owner.animation_alpha < 0.999) {
	animation_alpha = sqr(owner.animation_alpha);
	animation_scale = owner.animation_scale;
}

if clickable && scale_on_click && (moving || (clicked && hoovered)) {
	animation_scale = lerp(animation_scale, scale_on_click_ratio, scale_on_click_rate);
}
else
{
	animation_scale = lerp(animation_origin_scale, 1 , animation_progress);
}

if animation_scale < 0.1 {
	animation_scale = 0;
}


if animation_origin_offset_x == "center"{
	animation_origin_x_real = animation_origin_x_real + real_size_x/2;
}
if animation_origin_offset_x == "right"{
	animation_origin_x_real = animation_origin_x_real + real_size_x;
}

if animation_origin_offset_y == "center"{
	animation_origin_y_real = animation_origin_y_real + real_size_y/2;
}
if animation_origin_offset_y == "bottom"{
	animation_origin_y_real = animation_origin_y_real + real_size_y;
}

//set draw variables

draw_x = lerp(animation_origin_x_real, x, animation_progress);
draw_y = lerp(animation_origin_y_real, y, animation_progress);

draw_scale_x = real_size_x/sprite_get_width(sprite_box);
draw_scale_y = real_size_y/sprite_get_height(sprite_box);

//if childrens
var _child_ui_object_numb = ds_list_size(child_ui_object_list);
if _child_ui_object_numb > 0 {
	var _child_obj;
	var _x = child_ui_object_list_start_x;
	var _y = child_ui_object_list_start_y;
	var _max_size_x = child_ui_object_list_spacer_perp;
	var _max_size_y = child_ui_object_list_spacer_perp;
	var _max_x = child_ui_object_list_start_x;
	var _max_y = child_ui_object_list_start_y;

	for(var _i = 0; _i < _child_ui_object_numb; _i += 1){
		
		_child_obj = ds_list_find_value(child_ui_object_list, _i);
		
		if child_ui_object_list_direction == "up" {
			if _i != 0 {
				_y -= _child_obj.size_y + child_ui_object_list_spacer;
			}
		}
		
		if child_ui_object_list_direction == "left" {
			if _i != 0 {
				_x -= _child_obj.size_x + child_ui_object_list_spacer;
			}
		}
		
		if child_ui_object_list_direction == "right" {
			
			if child_ui_object_list_fit_break == "down" {
				
				if _x + _child_obj.size_x > size_x - border_x_len {
					_x = child_ui_object_list_start_x;
					_y += _max_size_y + child_ui_object_list_spacer_perp;
					_max_size_y = _child_obj.size_y;
				}
			}
		}

		if child_ui_object_list_direction == "down" {				
			if child_ui_object_list_fit_break == "right"
			&& _y + _child_obj.size_y > size_y - border_y_len {
				_y = child_ui_object_list_start_y;
				_x += _max_size_x + child_ui_object_list_spacer_perp;
				_max_size_x = _child_obj.size_x;
			}
		}
		
		_max_size_x = max(_child_obj.size_x + child_ui_object_list_spacer, _max_size_x);
		_max_size_y = max(_child_obj.size_y + child_ui_object_list_spacer, _max_size_y);
		
		_child_obj.relative_x = _x;
		_child_obj.relative_y = _y;
		
		if child_ui_object_list_direction == "down" {				
			_y += _child_obj.size_y + child_ui_object_list_spacer;
		}
		
		if child_ui_object_list_direction == "right" {
			_x += _child_obj.size_x + child_ui_object_list_spacer;
		}

		//if last element of list, remove spacer
		if _i == _child_ui_object_numb -1 {
		
			if child_ui_object_list_direction == "right" || child_ui_object_list_direction == "left" {
				_x = abs(_x) - child_ui_object_list_spacer + border_x_len;
			}
			else
			if child_ui_object_list_direction == "up" || child_ui_object_list_direction == "down" {
				_y = abs(_y) - child_ui_object_list_spacer + border_y_len;
			}		
		}
		
		_max_x = max(_max_size_x, abs(_x));
		_max_y = max(_max_size_y, abs(_y));

	}
	
	if child_ui_object_list_fit_size_x == true {
		size_x = _max_x;
	}
	
	if child_ui_object_list_fit_size_y == true {
		size_y = _max_y;
	}
}