function scr_textbox_step(){
	
	if animation_scale < 0.95 { exit; }
	
	// check important keys
	var _ctrl_check = (os_type == os_macosx) ? keyboard_check(VK_LCOMMAND) || keyboard_check(VK_RCOMMAND) : keyboard_check(vk_control);
	if (!selected) _ctrl_check = false;
	var _key_shift = keyboard_check(vk_shift) && selected;
	var _key_backspace = keyboard_check(vk_backspace) && selected;
	var _key_home_pressed = keyboard_check_pressed(vk_home) && selected;
	var _key_end_pressed = keyboard_check_pressed(vk_end) && selected;
	var _key_left = keyboard_check(vk_left) && selected;
	var _key_right = keyboard_check(vk_right) && selected;
	var _key_left_pressed = keyboard_check_pressed(vk_left) && selected;
	var _key_right_pressed = keyboard_check_pressed(vk_right) && selected;
	
	// check shortcuts
	var _shortcut_paste = _ctrl_check && keyboard_check_pressed(ord("V"));
	var _shortcut_copy = _ctrl_check && keyboard_check_pressed(ord("C"));
	var _shortcut_cut = _ctrl_check && keyboard_check_pressed(ord("x"));
	var _shortcut_select_all = _ctrl_check && keyboard_check_pressed(ord("A"));
	var _shortcut_jump_right = _ctrl_check && _key_right_pressed;
	var _shortcut_jump_left = _ctrl_check && _key_left_pressed;
	
	// set font here so that string width/height checks are accurate
	draw_set_font(txt_font);

	// make sure we don't get multiple keys inputting at once
	if (string_length(keyboard_string) > 1) {
		keyboard_string = string_char_at(keyboard_string, 1);
	}

	// get keyboard _input
	var _input = "";
	if (string_length(keyboard_string) > 0 && selected) _input = keyboard_string;
	if !selected keyboard_string = "";
	
	// CTRL+V (_paste)
	var _paste = false;
	if (_shortcut_paste) {
		if (clipboard_has_text()) {
			_paste = true;
			_input = clipboard_get_text();
		}
	}

	// get keyboard _input for typing in
	if (string_length(keyboard_string) == 1 || _shortcut_paste) {
	
		// delete highlighted text if there is any
		if (cursor_index != highlight_index) {
			var _min = min(cursor_index, highlight_index);
			var _max = max(cursor_index, highlight_index);
			var _delete_len = _max - _min;
			txt = string_delete(txt, _min + 1, _delete_len);
			if (cursor_index < highlight_index) {
				cursor_index = clamp(cursor_index, 0, string_length(txt));
				highlight_index = cursor_index;
			}
			else {
				highlight_index = clamp(highlight_index, 0, string_length(txt));
				cursor_index = highlight_index;
			}
		}
	
		// move cursor forward with new character
		cursor_index++;
		txt = string_insert(_input, txt, cursor_index);
		if (string_length(_input) > 1) cursor_index += string_length(_input) - 1;
		highlight_index = cursor_index;
	
		// dealing with cursor/clipping
		str_to_cursor = string_copy(txt, 1, cursor_index);
		cursor_x = txt_x + string_width(str_to_cursor)*global.gui_scale;
		if (cursor_x > x + real_size_x) x_offset -= string_width(_input)*global.gui_scale;
	
		// reset keyboard string
		if (selected) keyboard_string = "";
	}


	// backspace
	if (_key_backspace) {
		var _backspace_timer = os_type == os_macosx ? 1 : 0
		if (hold_backspace <= _backspace_timer || hold_backspace > 30) {
		
			// highlight backspace
			var _delete_len = 0;
			var _min = min(cursor_index, highlight_index);
			var _max = max(cursor_index, highlight_index);
			_delete_len = _max - _min;
			if (os_type == os_windows) {
				txt = string_delete(txt, _min + 1, _delete_len);
				cursor_index = _min;
				highlight_index = cursor_index;
			}
		
			// single char backspace
			if (_delete_len == 0) {
				var _str_to_del = string_copy(txt, cursor_index, 1);
				txt = string_delete(txt, cursor_index, 1);
				cursor_index--;
				highlight_index = cursor_index;
				if (x_offset < 0 && cursor_x < x + (real_size_x * 0.7)) {
					x_offset += string_width(_str_to_del)*global.gui_scale;
				}
			}
		}
		hold_backspace++;
	}
	else {
		hold_backspace = 0;
	}



	// LEFT ARROW (move cursor to previous character)
	if (_key_left && !_shortcut_jump_left && !_ctrl_check) {
		if (hold_arrow_left == 0 || hold_arrow_left > 30) {
			cursor_index--;
			if (!_key_shift) highlight_index = cursor_index;
			if (cursor_x < x + (real_size_x * 0.1)) x_offset += string_width("A")*global.gui_scale;
		}
		hold_arrow_left++;
	}
	else {
		hold_arrow_left = 0;
	}
	// RIGHT ARROW (move cursor to previous character)
	if (_key_right && !_shortcut_jump_right && !_ctrl_check) {
		if (hold_arrow_right == 0 || hold_arrow_right > 30) {
			cursor_index++;
			if (!_key_shift) highlight_index = cursor_index;
			if (cursor_x > x + (real_size_x * 0.9)) x_offset -= string_width("A")*global.gui_scale;
		}
		hold_arrow_right++;
	}
	else {
		hold_arrow_right = 0;
	}

	// drag and scroll outside of text box
	if selected {
		if (mouse_check_button(mb_left)) {
			if (cursor_index > highlight_index && mouse_x > x + real_size_x * 0.95) {
				if (x_offset > -(string_width(txt)*global.gui_scale - (real_size_x * 0.9))) {
					x_offset -= string_width("A")*global.gui_scale;
				}
			}
			else if ((cursor_index < highlight_index || cursor_x < 0) && mouse_x < x + real_size_x * 0.05) {
				if (x_offset < 0) {
					x_offset += string_width("A")*global.gui_scale;
				}
			}
		}
	}




	// HOME (move cursor to begining of text)
	if (_key_home_pressed) {
		cursor_index = 0;
		x_offset = 0;
		if (!_key_shift) highlight_index = cursor_index;
	}
	// END (move cursor to end of text)
	if (_key_end_pressed) {
		cursor_index = string_length(txt);
		x_offset = -(string_width(txt)*global.gui_scale - (real_size_x * 0.9));
		if (!_key_shift) highlight_index = cursor_index;
	}
	// CTRL+A (select all)
	if (_shortcut_select_all) {
		cursor_index = 0;
		highlight_index = string_length(txt);
		x_offset = 0;
	}
	// CTRL+C (copy)
	if (_shortcut_copy && cursor_index != highlight_index) {
		var _min = min(cursor_index, highlight_index);
		var _max = max(cursor_index, highlight_index);
		clipboard_set_text(string_copy(txt, _min + 1, _max - _min));
	}
	// CTRL+x (cut)
	if (_shortcut_cut && cursor_index != highlight_index) {
		var _min = min(cursor_index, highlight_index);
		var _max = max(cursor_index, highlight_index);
		clipboard_set_text(string_copy(txt, _min + 1, _max - _min));
		var _delete_len = _max - _min;
		if (os_type == os_windows) {
			txt = string_delete(txt, _min + 1, _delete_len);
			cursor_index = _min;
			highlight_index = cursor_index;
		}
	}
	// CTRL+RIGHT ARROW (jump cursor to next letter character)
	if (_shortcut_jump_right) {
		if (cursor_index < string_length(txt)) cursor_index++;
		while (scr_is_char_letter(string_char_at(txt, cursor_index)) && cursor_index < string_length(txt)) cursor_index++;
		if (cursor_index + 1 < string_length(txt)) {
			while (!scr_is_char_letter(string_char_at(txt, cursor_index + 1)) && cursor_index < string_length(txt)) cursor_index++;
		}
		if (!_key_shift) highlight_index = cursor_index;
	}
	// CTRL+LEFT ARROW (jump cursor to previous letter character)
	if (_shortcut_jump_left) {
		if (cursor_index > 0) cursor_index--;
		while (scr_is_char_letter(string_char_at(txt, cursor_index)) && cursor_index > 0) cursor_index--;
		if (cursor_index - 1 > 0) {
			while (!scr_is_char_letter(string_char_at(txt, cursor_index)) && cursor_index  > 0) cursor_index--;
		}
		if (!_key_shift) highlight_index = cursor_index;
	}

	// clamp cursor & highlight indexes so they're within string
	cursor_index = clamp(cursor_index, 0, string_length(txt));
	highlight_index = clamp(highlight_index, 0, string_length(txt));

	// get str_to_cursor, so we know where to draw the cursor
	str_to_cursor = string_copy(txt, 1, cursor_index);
	str_to_highlight = string_copy(txt, 1, highlight_index);

	// release command holding keys for mac
	if (os_type == os_macosx) {
		if (keyboard_check_released(VK_RCOMMAND) || keyboard_check_released(VK_LCOMMAND)) {
			keyboard_key_release(vk_left);
			keyboard_key_release(vk_right);
		}
	}
	
	// make sure x_offset is at least 0
	x_offset = min(x_offset, 0);
	
	// decrease double_click_timer
	double_click_timer = max(double_click_timer - 1, 0);
}