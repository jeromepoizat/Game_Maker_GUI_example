//TODO: move this in object create event ?
function scr_textbox_surface_start(){
	clip_x = draw_x + txt_border_x_len;
	clip_y = draw_y;
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
	surface_set_target(clip_surface);
	draw_clear_alpha(c_black, 0);
}