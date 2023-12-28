global.gui_x = window_get_width();
global.gui_y = window_get_height();
global.gui_scale = 1.4;

//TODO: fix relative child position when gui rescale

//create interface
var a = instance_create_depth(
	global.gui_x/2,
	global.gui_y/2,	
	1,
	obj_GUIbox
);
with(a){
	size_x = 600;
	size_y = 400;
	txt = "WINDOW";
	movable = false;
	resizable = true;
	owner_relative_x = "right"
}

var b = instance_create_depth(
	0,
	0,	
	0,
	obj_GUIbox
)
with(b){
	owner = a;
	size_x = 150;
	size_y = 150;
	txt = "BUTTON";
	movable = true;
	clickable = true;
}

