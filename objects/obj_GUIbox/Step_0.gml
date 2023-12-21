var _mouse_gui_x = device_mouse_x_to_gui(0);
var _mouse_gui_y = device_mouse_y_to_gui(0);

var _owner_x = 0;
var _owner_y = 0;
var _owner_size_x = global.gui_x;
var _owner_size_y = global.gui_y;

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
			moving = true;
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
	
	//keep object in ui borders
	if x < _owner_x {
		x = _owner_x;
	}
	if x + real_size_x > _owner_size_x {
		x = _owner_size_x - real_size_x;
	}
	if y < _owner_y {
		y = _owner_y;
	}
	if y + real_size_y > _owner_size_y {
		y = _owner_size_y - real_size_y;
	}
}
else
if resizable {
	if ( resizing_left || resizing_right || resizing_top || resizing_bottom ){

		var _old_size_x = size_x;
		var _old_size_y = size_y;

		if resizing_left {		
			if ((_mouse_gui_x - click_x) > _owner_x && _mouse_gui_x > x)
			|| ((_mouse_gui_x - click_x) < _owner_x && _mouse_gui_x < x){
				size_x = size_x - (_mouse_gui_x - click_x);
				
				if size_x < size_x_min {
					size_x = size_x_min;
				}	
				else
				if size_x > size_x_max {
					size_x = size_x_max;	
				}
				
				box_fit_txt();

				x = x - (size_x - _old_size_x);
				
				if x < _owner_x { 
					size_x = size_x + x;
					x = _owner_x;
				}
			}
		}

		if resizing_right {
			if ((_mouse_gui_x - click_x) > _owner_x && _mouse_gui_x > x + real_size_x)
			|| ((_mouse_gui_x - click_x) < _owner_x && _mouse_gui_x < x + real_size_x){			
				size_x = size_x + (_mouse_gui_x - click_x);
				
				if size_x < size_x_min {
					size_x = size_x_min;
				}	
				else
				if size_x > size_x_max {
					size_x = size_x_max;
				}
				
				box_fit_txt();
				
				if x + size_x > _owner_size_x {
					size_x = _owner_size_x - x;
				}
			}
		}

		if resizing_top {
			if ((_mouse_gui_y - click_y) > _owner_x && _mouse_gui_y > y)
			|| ((_mouse_gui_y - click_y) < _owner_x && _mouse_gui_y < y){
				size_y = size_y - (_mouse_gui_y - click_y);
				
				if size_y < size_y_min {
					size_y = size_y_min;
				}	
				else
				if size_y > size_y_max {
					size_y = size_y_max;	
				}	
				
				box_fit_txt();

				y = y - (size_y - _old_size_y);
				
				if y < _owner_x { 
					size_y = size_y + y;
					y = _owner_x;
				}
			}	
		}

		if resizing_bottom {
			if ((_mouse_gui_y - click_y) > _owner_x && _mouse_gui_y > y + real_size_y)
			|| ((_mouse_gui_y - click_y) < _owner_x && _mouse_gui_y < y + real_size_y){			
				size_y = size_y + (_mouse_gui_y - click_y);
				
				if size_y < size_y_min {
					size_y = size_y_min;
				}	
				else
				if size_y > size_y_max {
					size_y = size_y_max;
				}
				
				box_fit_txt();
				
				if y + size_y > _owner_size_y {
					size_y = _owner_size_y - y;
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


//refresh variables

draw_x = x;
draw_y = y;
real_size_x = size_x*global.gui_scale;
real_size_y = size_y*global.gui_scale;
draw_scale_x = real_size_x/sprite_get_width(sprite_box);
draw_scale_y = real_size_y/sprite_get_height(sprite_box);