function scr_ui_draw(_surface_delta_x = 0, _surface_delta_y = 0){
	/// @description 
	if animation_scale + animation_alpha == 0 {exit;}
	
	//draw box
	
	draw_sprite_ext(sprite_box, draw_sub,
					draw_x - _surface_delta_x, draw_y - _surface_delta_y,
					draw_scale_x*animation_scale,
					draw_scale_y*animation_scale,
					0, c_white, draw_alpha*animation_alpha
	);
			
	if txt != "" {
		draw_set_halign(fa_center);
		draw_set_valign(fa_middle);
		draw_set_font(txt_font);
		if writable == false {
			if fit_txt_width {
				draw_text_transformed_color(
					draw_x + (real_size_x*animation_scale)/2 - _surface_delta_x,
					draw_y + (real_size_y*animation_scale)/2 - _surface_delta_y,
					txt,
					global.gui_scale*animation_scale,
					global.gui_scale*animation_scale,
					0,
					c_white,c_white,c_ltgray,c_yellow,
					draw_alpha*animation_alpha
				);		
			}
			else {
				draw_text_ext_transformed_color(
					draw_x + (real_size_x*animation_scale)/2 - _surface_delta_x,
					draw_y + (real_size_y*animation_scale)/2 - _surface_delta_y,
					txt,
					-1,
					size_x - txt_border_x_len*2,
					global.gui_scale*animation_scale,
					global.gui_scale*animation_scale,
					0,
					c_white,c_white,c_ltgray,c_yellow,
					draw_alpha*animation_alpha
				);
			}
		}
		else {
			scr_textbox_draw(_surface_delta_x, _surface_delta_y, ui_surface_to_draw_on);	
		}
	}
	
	
	if ui_surface_create == true {
		
		var _surf_width = real_size_x - child_ui_object_list_start_x*global.gui_scale - txt_border_x_len;
		var _surf_height = real_size_y - child_ui_object_list_start_y*global.gui_scale - txt_border_y_len;
		
	
		if (!surface_exists(ui_surface)) {
			ui_surface = surface_create(_surf_width, _surf_height);
		} 
		else 
		if surface_get_height(ui_surface) != _surf_height 
		|| surface_get_width(ui_surface) != _surf_width {
			surface_resize(ui_surface, _surf_width, _surf_height);		
		}
	
		var child_ui_object_numb = ds_list_size(child_ui_object_list);
		if child_ui_object_numb > 0 {
			
			surface_set_target(ui_surface);
			draw_clear_alpha(c_black, 0);
			
		
			var child_obj;
			for(var _i = 0; _i < child_ui_object_numb; _i += 1){	
				child_obj = ds_list_find_value(child_ui_object_list, _i);
				with(child_obj){
					
					ui_surface = other.ui_surface;
					ui_surface_to_draw_on = other.ui_surface;			
					scr_ui_draw(other.draw_x + other.txt_border_x_len, other.draw_y + other.txt_border_y_len);

				}
			}
			

			surface_reset_target();
	

			draw_surface(
				ui_surface,
				draw_x + txt_border_x_len,
				draw_y + txt_border_y_len
			);

		}
	}
	
	if ui_surface_to_draw_on != noone {
		var child_ui_object_numb = ds_list_size(child_ui_object_list);
		for(var _i = 0; _i < child_ui_object_numb; _i += 1){	
			child_obj = ds_list_find_value(child_ui_object_list, _i);
			with(child_obj){
				ui_surface = other.ui_surface;
				ui_surface_to_draw_on = other.ui_surface_to_draw_on;			
				scr_ui_draw(_surface_delta_x, _surface_delta_y);
			}
		}		
	}
}