function scr_textbox_draw(_surface_delta_x = 0, _surface_delta_y = 0, _surface = noone){
	
	// set text positions and window height
	draw_set_font(txt_font);
	var _str_len = string_length(txt);
	var _str_height = string_height("A")*global.gui_scale;
	var _text_margin_x = 10;
	var _text_margin_y = 10;
	txt_x = txt_border_x_len + floor(draw_x + _text_margin_x + x_offset);
	txt_y = txt_border_y_len + floor(draw_y + _text_margin_y);
	//real_size_y = _str_height + (_text_margin_y * 2);
	
	if selected {
		// moving cursor with mouse click
		if (mouse_check_button(mb_left)) {
			var _closest_char_to_mouse = 0;
			var _min_dist_to_mouse = 999999999;
		
			// find closest character to mouse
			for (var _i = 0; _i <= _str_len; _i++) {
				var _sub_str = string_copy(txt, 1, _i);
				var _sub_str_x = txt_x + string_width(_sub_str)*global.gui_scale;
				var _sub_str_y = txt_y;
				var _dist_to_mouse = point_distance(mouse_x, mouse_y, _sub_str_x, _sub_str_y);
				if (_dist_to_mouse < _min_dist_to_mouse) {
					_min_dist_to_mouse = _dist_to_mouse;
					_closest_char_to_mouse = _i;
				}
			}
		
			// check to move cursor/highlight index
			if (mouse_check_button_pressed(mb_left)) {
				valid_drag = hoovered;
				if (valid_drag) highlight_index = _closest_char_to_mouse;
			}
			if (valid_drag) cursor_index = _closest_char_to_mouse;
		
			// check if double-clicking
			/*
			if (mouse_check_button_pressed(mb_left) && valid_drag && hoovered) {
				if (double_click_timer > 0) double_click = true;
				else double_click_timer = double_click_timer_full;
			}
			*/
		}

		if (mouse_check_button_released(mb_left)) {
			valid_drag = true;
		
			// double click to select word
			if (double_click) {
				double_click = false;
				while (scr_is_char_letter(string_char_at(txt, cursor_index)) && cursor_index < _str_len) cursor_index++;
				while (scr_is_char_letter(string_char_at(txt, highlight_index)) && highlight_index > 0) highlight_index--;
				if (cursor_index < _str_len || !scr_is_char_letter(string_char_at(txt, cursor_index))) cursor_index--;
			}
		}

	}
	
	// start clipping for text
	scr_textbox_surface_start(_surface_delta_x, _surface_delta_y);

	// draw text
	draw_set_font(txt_font);
	draw_set_color(txt_color);
	draw_set_alpha(1);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_text_transformed_color(
		txt_x - clip_x - _surface_delta_x,
		txt_y - clip_y - _surface_delta_y,
		txt,
		global.gui_scale*animation_scale,
		global.gui_scale*animation_scale,
		0,
		c_white,c_white,c_ltgray,c_yellow,
		draw_alpha*animation_alpha
	);

	// draw cursor
	cursor_x = txt_x + string_width(str_to_cursor)*global.gui_scale;
	var _cursor_y1 = txt_y;
	var _cursor_y2 = _cursor_y1 + _str_height;
	if (selected) && animation_scale > 0.95 {
		var _draw_cursor_real = false;
		if (draw_cursor || keyboard_check(vk_anykey)) _draw_cursor_real = true;
		if (_draw_cursor_real) {
			draw_set_color(cursor_color);
			draw_line_width(
				cursor_x - clip_x - _surface_delta_x,
				_cursor_y1 - clip_y - _surface_delta_y,
				cursor_x - clip_x - _surface_delta_x,
				_cursor_y2 - clip_y - _surface_delta_y,
				2*global.gui_scale
			);
		}
	}

	// draw highlight rect if we need to
	var _draw_highlight_rect = (mouse_check_button(mb_left) || cursor_index != highlight_index);
	if (_draw_highlight_rect) {
		var _highlight_x = txt_x + string_width(str_to_highlight)*global.gui_scale;
	
		var _highlight_rect_x1 = min(cursor_x, _highlight_x);
		var _highlight_rect_y1 = _cursor_y1;
		var _highlight_rect_x2 = max(cursor_x, _highlight_x);
		var _highlight_rect_y2 = _cursor_y2;
	
		draw_set_color(highlight_color);
		draw_set_alpha(0.6);
		draw_rectangle(
			_highlight_rect_x1 - clip_x  - _surface_delta_x,
			_highlight_rect_y1 - clip_y  - _surface_delta_y,
			_highlight_rect_x2 - clip_x  - _surface_delta_x,
			_highlight_rect_y2 - clip_y  - _surface_delta_y,
			false
		);
		draw_set_alpha(1);
	}

	// end clipping for text
	scr_textbox_surface_end(_surface);
	
	//draw icons for hidden text info
	if animation_scale > 0.95 {
		if x_offset < 0 {
			//hidden text on the left
			draw_text(
				draw_x - _surface_delta_x,
				draw_y - _surface_delta_y,
				"<"
			);
		}
	
		if string_width(txt)*global.gui_scale + x_offset > real_size_x - txt_border_x_len*2 {
			//hidden text on the right
			draw_text(
				draw_x + real_size_x - txt_border_x_len*2 - _surface_delta_x,
				y - _surface_delta_y,
				">"
			);
		}
	}
	

}