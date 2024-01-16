//TODO: move this in object create event ?
function scr_textbox_surface_start(_surface_delta_x = 0, _surface_delta_y = 0){
	clip_x = draw_x + txt_border_x_len - _surface_delta_x;
	clip_y = draw_y - _surface_delta_y;
	clip_width = real_size_x - txt_border_x_len*2;
	clip_height = real(real_size_y); //real is used here to remove GM suggestion not knowing variable type
	// create a surface if it doesn't exist:
	if (!surface_exists(clip_surface)) {
	    clip_surface = surface_create(clip_width, clip_height);
	} 
	else 
	if surface_get_height(clip_surface) != clip_height || surface_get_width(clip_surface) != clip_width {
		surface_resize(clip_surface, clip_width, clip_height);		
	}
	// clear and start drawing to surface:
	if ui_surface != noone {
		surface_reset_target();
	}
	surface_set_target(clip_surface);
	draw_clear_alpha(c_black, 0);
}