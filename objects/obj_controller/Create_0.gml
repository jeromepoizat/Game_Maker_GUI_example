//TODO: move this
global.gui_x = window_get_width();
global.gui_y = window_get_height();
global.gui_scale = 1.8;

//create interface
instance_create_depth(
	global.gui_x/2,
	global.gui_y/2,	
	0,
	obj_GUIbox
	);