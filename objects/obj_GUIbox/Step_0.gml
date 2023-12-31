if visible == false {exit;}

txt = string(animation_state);

var _mouse_gui_x = device_mouse_x_to_gui(0);
var _mouse_gui_y = device_mouse_y_to_gui(0);

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

if !moving && (resizing_left + resizing_right + resizing_top + resizing_bottom) == 0 {
	real_relative_x = relative_x*global.gui_scale;
	real_relative_y = relative_y*global.gui_scale;
} 
else 
{
	if old_scale == global.gui_scale {
		relative_x = real_relative_x/global.gui_scale;
		relative_y = real_relative_y/global.gui_scale;
	}
	else
	{
		real_relative_x = relative_x*global.gui_scale;
		real_relative_y = relative_y*global.gui_scale;		
		old_scale = global.gui_scale;
	}
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

box_fit_txt()


if writable {
	scr_textbox_step();	
}

//check if mouse is hoovering
if _mouse_gui_x > x - hoover_err
&& _mouse_gui_x < x + real_size_x + hoover_err
&& _mouse_gui_y > y - hoover_err
&& _mouse_gui_y < y + real_size_y + hoover_err {
	//hoover
	hoovered = true;
	
	if resizable == true {
		if (resizing_left + resizing_right + resizing_top + resizing_bottom) == 0 {
			//check if on resizing left border
			if _mouse_gui_x >= x - hoover_err
			&& _mouse_gui_x <= x + resize_border_len {
				hoover_resizing_left = true;	
			} else {
				hoover_resizing_left = false;	
			}

			//check if on resizing right border

			if _mouse_gui_x <= x + real_size_x + hoover_err
			&& _mouse_gui_x >= x + real_size_x - resize_border_len {
				hoover_resizing_right = true;	
			} else {
				hoover_resizing_right = false;
			}

			//check if on resizing top border

			if _mouse_gui_y >= y - hoover_err
			&& _mouse_gui_y <= y + resize_border_len {
				hoover_resizing_top = true;	
			} else {
				hoover_resizing_top = false;	
			}

			//check if on resizing bottom border

			if _mouse_gui_y <= y + real_size_y  + hoover_err
			&& _mouse_gui_y >= y + real_size_y - resize_border_len {
				hoover_resizing_bottom = true;	
			} else {
				hoover_resizing_bottom = false;
			}
		}
	}
	
	if mouse_check_button(mb_left){
		
		if clicked == false {
			clicked = true;
			click_x = _mouse_gui_x;
			click_y = _mouse_gui_y;
			
			if selectable {
				selected = true;	
			}
			
			if resizable {
				resizing_left = hoover_resizing_left;	
				resizing_right = hoover_resizing_right;
				resizing_top = hoover_resizing_top;
				resizing_bottom = hoover_resizing_bottom;
			}
		}
		
		click_timer += 1;
		
		if movable == true {
			if (resizing_left + resizing_right + resizing_top + resizing_bottom) == 0  {
				moving = true;
			}
		}
	}
	else {
		clicked = false;
		click_timer = 0;	
	}
}
else {
	//mouse not hoovering
	hoovered = false;
	draw_sub = sub_idle;
	
	if resizing_left == false {
		hoover_resizing_left = false;
	}
	if resizing_right == false {
		hoover_resizing_right = false;
	}
	if resizing_top == false {
		hoover_resizing_top = false;
	}
	if resizing_bottom == false {
		hoover_resizing_bottom = false;
	}
}



if mouse_check_button_released(mb_left){
		 
	clicked = false;
	click_timer = 0;
	
	moving = false;
	
	resizing_left = false;
	resizing_right = false;
	resizing_top = false;
	resizing_bottom = false;
	
	if !hoovered {
		selected = false;
	}
}

if moving {
	clicked = true;
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
			if ((_mouse_gui_x - click_x) > _owner_x && _mouse_gui_x > x)
			|| ((_mouse_gui_x - click_x) < _owner_x && _mouse_gui_x < x){
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
				
				if x < _owner_x { 
					size_x = size_x + x/global.gui_scale;
					x = _owner_x;
				}
			}
		}

		if resizing_right {
			if ((_mouse_gui_x - click_x) > _owner_x && _mouse_gui_x > x + real_size_x)
			|| ((_mouse_gui_x - click_x) < _owner_x && _mouse_gui_x < x + real_size_x){			
				size_x = size_x + (_mouse_gui_x - click_x)/global.gui_scale;
				
				if size_x < size_x_min {
					size_x = size_x_min;
				}	
				else
				if size_x > size_x_max {
					size_x = size_x_max;
				}
				
				box_fit_txt();
				
				if x + size_x*global.gui_scale > _owner_size_x {
					size_x = (_owner_size_x - x)/global.gui_scale;
				}
			}
		}

		if resizing_top {
			if ((_mouse_gui_y - click_y) > _owner_x && _mouse_gui_y > y)
			|| ((_mouse_gui_y - click_y) < _owner_x && _mouse_gui_y < y){
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
				
				if y < _owner_x { 
					size_y = size_y + y/global.gui_scale;
					y = _owner_x;
				}
			}	
		}

		if resizing_bottom {
			if ((_mouse_gui_y - click_y) > _owner_x && _mouse_gui_y > y + real_size_y)
			|| ((_mouse_gui_y - click_y) < _owner_x && _mouse_gui_y < y + real_size_y){			
				size_y = size_y + (_mouse_gui_y - click_y)/global.gui_scale;
				
				if size_y < size_y_min {
					size_y = size_y_min;
				}	
				else
				if size_y > size_y_max {
					size_y = size_y_max;
				}
				
				box_fit_txt();
				
				if y + size_y*global.gui_scale > _owner_size_y {
					size_y = (_owner_size_y - y)/global.gui_scale;
				}
			}			
		}
	
	click_x = _mouse_gui_x;
	click_y = _mouse_gui_y;	
	
	}
	
}

//set sub-image
if clickable && clicked {
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
//tmp
if resizing_left || resizing_right || resizing_top || resizing_bottom  {
 draw_sub = sub_hoover_selected;		
}

if (writable && (hoovered || clicked)){
	window_set_cursor(cr_beam);
}
else
if (clickable && (hoovered || clicked)){
	window_set_cursor(cr_handpoint);
}
else
if (moving == true){
	window_set_cursor(cr_size_all);
}
else
if ( hoover_resizing_left && hoover_resizing_top)
|| (hoover_resizing_right && hoover_resizing_bottom){
	window_set_cursor(cr_size_nwse);
}
else
if ( hoover_resizing_left && hoover_resizing_bottom)
|| (hoover_resizing_right && hoover_resizing_top){
	window_set_cursor(cr_size_nesw);
}
else
if hoover_resizing_left || hoover_resizing_right {
	window_set_cursor(cr_size_we);
}
else
if hoover_resizing_top || hoover_resizing_bottom {
	window_set_cursor(cr_size_ns);
}
else
{
	window_set_cursor(cr_default);
}


if owner_center_x == true {
	x = _owner_x + _owner_size_x/2 - real_size_x/2;	
}

if owner_center_y == true {
	y = _owner_y + _owner_size_y/2 - real_size_y/2;	
}


//keep object in ui borders
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

//refresh variables
real_size_x = size_x*global.gui_scale;
real_size_y = size_y*global.gui_scale;

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
	animation_origin_x_real = x + animation_origin_x_relative;
	animation_origin_y_real = y + animation_origin_y_relative;
	
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
}
else
if animation_origin_type == "owner" {
	animation_origin_x_real = owner.animation_origin_x_real + animation_origin_x_relative;
	animation_origin_y_real = owner.animation_origin_y_real + animation_origin_y_relative;
}


if instance_exists(owner) && (owner.animation_scale < 0.98) {
	animation_origin_x_real = owner.animation_origin_x_real + animation_origin_x_relative;
	animation_origin_y_real = owner.animation_origin_y_real + animation_origin_y_relative;
}

if instance_exists(owner) && (owner.animation_progress < 0.98) {
	animation_progress = owner.animation_progress;		
}

animation_scale = lerp(animation_origin_scale, 1, animation_progress);
animation_alpha = lerp(animation_origin_alpha, 1, animation_progress);
draw_x = lerp(animation_origin_x_real, x, animation_progress);
draw_y = lerp(animation_origin_y_real, y, animation_progress);


draw_scale_x = real_size_x/sprite_get_width(sprite_box);
draw_scale_y = real_size_y/sprite_get_height(sprite_box);