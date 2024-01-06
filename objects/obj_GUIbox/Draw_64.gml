/// @description 
if animation_scale + animation_alpha == 0 {exit;}

//draw box
draw_sprite_ext(sprite_box, draw_sub,
				draw_x, draw_y,
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
				draw_x + (real_size_x*animation_scale)/2,
				draw_y + (real_size_y*animation_scale)/2,
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
				draw_x + (real_size_x*animation_scale)/2,
				draw_y + (real_size_y*animation_scale)/2,
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
		scr_textbox_draw();	
	}
}



