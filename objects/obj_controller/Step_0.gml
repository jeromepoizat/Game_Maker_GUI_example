var _mouse_gui_x = device_mouse_x_to_gui(0);
var _mouse_gui_y = device_mouse_y_to_gui(0);

var _mouse_left = mouse_check_button(mb_left);
var _mouse_left_press = mouse_check_button_pressed(mb_left);
var _mouse_left_release = mouse_check_button_released(mb_left);

hoover_resizing_left = false;
hoover_resizing_right = false;
hoover_resizing_top = false;
hoover_resizing_bottom = false;

//check if saved ui_objects are scaled
if instance_exists(ui_object_selected){
	if ui_object_selected.animation_scale < 0.95 || ui_object_selected.animation_alpha < 0.95 {
		ui_object_selected.selected = false;
		ui_object_selected = noone;
	}
}
if instance_exists(ui_object_moving){
	if ui_object_moving.animation_scale < 0.95 || ui_object_moving.animation_alpha < 0.95 {
		ui_object_moving.moving = false;
		ui_object_moving = noone;
	}
}
if instance_exists(ui_object_resizing){
	if ui_object_resizing.animation_scale < 0.95 || ui_object_resizing.animation_alpha < 0.95 {
		ui_object_resizing.resizing_left = false;
		ui_object_resizing.resizing_right = false;
		ui_object_resizing.resizing_top = false;
		ui_object_resizing.resizing_bottom = false;
		ui_object_resizing = noone;
	}
}

//if click, unselect everything
if _mouse_left_press {	
	if instance_exists(ui_object_selected){
		ui_object_selected.selected = false;
		ui_object_selected = noone;
	}
}

//if unclick, cancel move and resize
if _mouse_left_release {
	
	if instance_exists(ui_object_clicked){
		ui_object_clicked.clicked = false;
		ui_object_clicked.click_timer = 0;
		ui_object_clicked = noone;
	}
	
	if instance_exists(ui_object_moving){
		ui_object_moving.moving = false;
		ui_object_moving = noone;
	}
	
	if instance_exists(ui_object_resizing){
		ui_object_resizing.resizing_left = false;
		ui_object_resizing.resizing_right = false;
		ui_object_resizing.resizing_top = false;
		ui_object_resizing.resizing_bottom = false;
		ui_object_resizing = noone;
	}
}

if instance_exists(ui_object_hoovered){
	ui_object_hoovered.hoovered = false;
	ui_object_hoovered = noone;
}

//if nothing is being moved or resized
if ui_object_moving == noone && ui_object_resizing == noone {
	//loop all ui layers (sttart from furthest)
	var _ui_object_list;
	var _ui_object;
	var _j
	var _break_loop_layers = false;
	for(var _i = 9; _i >= 0; _i -= 1){
		_ui_object_list = global.ui_object_list_layer[_i];
		
		//loop all ui objects of that layer
		var _ui_object_list_size = ds_list_size(_ui_object_list);
		_j = 0;
		repeat(_ui_object_list_size){
			_ui_object = ds_list_find_value(_ui_object_list, _j);
			_j += 1;
			with(_ui_object){
				if animation_scale >= 0.90 && animation_alpha >= 0.90 && visible {
					//check if hoovered,
					if _mouse_gui_x > x - hoover_err
					&& _mouse_gui_x < x + real_size_x + hoover_err
					&& _mouse_gui_y > y - hoover_err
					&& _mouse_gui_y < y + real_size_y + hoover_err {
						//hoover
						hoovered = true;
						other.ui_object_hoovered = _ui_object;
						//if hoovered detected, break layer loop (can only hoover one element at once)
						_break_loop_layers = true;
						
						//check if hoover resize borders
						if resizable 
						&& (resizing_left + resizing_right + resizing_top + resizing_bottom) == 0 {
							
							//check if on resizing left border
							if _mouse_gui_x >= x - hoover_err
							&& _mouse_gui_x <= x + resize_border_len {
								other.hoover_resizing_left = true;	
							}

							//check if on resizing right border

							if _mouse_gui_x <= x + real_size_x + hoover_err
							&& _mouse_gui_x >= x + real_size_x - resize_border_len {
								other.hoover_resizing_right = true;	
							}

							//check if on resizing top border

							if _mouse_gui_y >= y - hoover_err
							&& _mouse_gui_y <= y + resize_border_len {
								other.hoover_resizing_top = true;	
							}

							//check if on resizing bottom border

							if _mouse_gui_y <= y + real_size_y + hoover_err
							&& _mouse_gui_y >= y + real_size_y - resize_border_len {
								other.hoover_resizing_bottom = true;	
							}			
						}// end check hoover resize borders
						
						//check click
						if _mouse_left {
							
							click_timer += 1;
							
							//click action
							if clicked == false && _mouse_left_press {
								clicked = true;
								click_x = _mouse_gui_x;
								click_y = _mouse_gui_y;
								other.ui_object_clicked = _ui_object;
			
								if selectable {
									selected = true;
									other.ui_object_selected = _ui_object;
								}
			
								if resizable {
									resizing_left = other.hoover_resizing_left;	
									resizing_right = other.hoover_resizing_right;
									resizing_top = other.hoover_resizing_top;
									resizing_bottom = other.hoover_resizing_bottom;
									if (resizing_left + resizing_right + resizing_top + resizing_bottom) != 0 {
										other.ui_object_resizing = _ui_object;
									}
								}
								
								if scroller {
									if instance_exists(owner){
										if scroller_direction = "right" {
											//owner.scroll_x = owner.scroll_length_x*(x - click_x)/size_x;
										}
										if scroller_direction = "down" {
											show_debug_message(
												"-child_ui_top_most_y : "+string(-owner.child_ui_top_most_y)
											)
											
											show_debug_message(
												"child_ui_down_most_y : "+string(-owner.child_ui_down_most_y)
											)
											
											show_debug_message(
												"(y - click_y)/real_size_y : "+string(-(y - click_y)/real_size_y)
											)
											
											owner.scroll_y = lerp(-owner.child_ui_top_most_y,
																-owner.child_ui_down_most_y,
																-(y - click_y)/real_size_y);
											show_debug_message(
											"scroll_y : "+string(owner.scroll_y)
											)
										}
									}
								}
							} //end click action
							
							//check movable
							if _mouse_left_press
							&& movable == true 
							&& (resizing_left + resizing_right + resizing_top + resizing_bottom) == 0 {
								moving = true;
								other.ui_object_moving = _ui_object;
							} // end check movable
							
						} // end check click
						
					} // end check hoovered

				} // end check if scaled and visible
			}
			if _break_loop_layers {
				break;	
			}
		} // end loop ui_objects of layer
		if _break_loop_layers {
			break;	
		}
	} // end loop layers
}
 

//cursor
window_set_cursor(cr_default);

if instance_exists(ui_object_hoovered){
	
	if ui_object_hoovered.writable {
		window_set_cursor(cr_beam);
	}
	else 
	if ui_object_hoovered.clickable {
		window_set_cursor(cr_handpoint);
	}	
}

if instance_exists(ui_object_moving){
	window_set_cursor(cr_size_all);
}

if instance_exists(ui_object_resizing){
	with(ui_object_resizing){
		if ( resizing_left && resizing_top)
		|| ( resizing_right && resizing_bottom){
			window_set_cursor(cr_size_nwse);
		}
		else
		if ( resizing_left && resizing_bottom)
		|| ( resizing_right && resizing_top){
			window_set_cursor(cr_size_nesw);
		}
		else
		if resizing_left || resizing_right {
			window_set_cursor(cr_size_we);
		}
		else
		if resizing_top || resizing_bottom {
			window_set_cursor(cr_size_ns);
		}
	}
} else {
	if ( hoover_resizing_left && hoover_resizing_top)
	|| ( hoover_resizing_right && hoover_resizing_bottom){
		window_set_cursor(cr_size_nwse);
	}
	else
	if ( hoover_resizing_left && hoover_resizing_bottom)
	|| ( hoover_resizing_right && hoover_resizing_top){
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
}

