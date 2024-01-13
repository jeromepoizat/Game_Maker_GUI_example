function scr_textbox_surface_end(_surface = noone){
	// finish and draw the surface itself:
	if _surface == noone {
		surface_reset_target();
	}
	else
	{
		surface_reset_target();
		surface_set_target(_surface);
	}
	
	draw_surface(clip_surface, clip_x, clip_y);
}