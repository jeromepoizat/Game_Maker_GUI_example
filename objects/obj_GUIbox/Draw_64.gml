/// @description 

//draw box
draw_sprite_ext(sprite_box, draw_sub,
				draw_x, draw_y,
				draw_scale_x, draw_scale_y,
				0, c_white, draw_alpha
				);
				
if txt != "" {
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	if fit_txt_width {
		draw_text_transformed_color(
			x + real_size_x/2,
			y + real_size_y/2,
			txt,
			1,
			1,
			0,
			c_white,c_white,c_ltgray,c_yellow,
			draw_alpha
		);		
	}
	else {
		draw_text_ext_transformed_color(
			x + real_size_x/2,
			y + real_size_y/2,
			txt,
			-1,
			real_size_x - txt_border_x_len*2,
			1,
			1,
			0,
			c_white,c_white,c_ltgray,c_yellow,
			draw_alpha
		);
	}
}



