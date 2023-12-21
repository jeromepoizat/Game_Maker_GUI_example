function scr_textbox_surface_end(){
	// finish and draw the surface itself:
	surface_reset_target();
	draw_surface(clip_surface, clip_x, clip_y);
}