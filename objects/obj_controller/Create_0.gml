global.gui_x = window_get_width();
global.gui_y = window_get_height();
global.gui_scale = 1.2;

//TODO: option to fit animation origin:
//animation origin offset :center, left, rigth
//animation origin offset :center, top, bottom
//animation origin type: self or owner // so it also moves when self or owner moves
//animation origin x :real (relative to self or owner)
//animation origin y :real (relative to self or owner)
//animation origin scale: 0 - 1
//animation lerp spd

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
	movable = true;
	resizable = true;
	owner_center_x = false;
	owner_center_y = false;
	animation_origin_x = global.gui_x/2;
	animation_origin_y = 0//global.gui_y;
	animation_state = 1;
	//animation_origin_offset_x = "center";
	//animation_origin_offset_y = "center";
}
global.a = a;

var b = instance_create_depth(
	0,
	0,	
	0,
	obj_GUIbox
)
with(b){
	owner = a;
	size_x = 120;
	size_y = 120;
	txt = "BUTTON";
	movable = true;
	clickable = true;
	owner_relative_x = "right";
	owner_relative_y = "top";
}

var c = instance_create_depth(
	0,
	0,	
	0,
	obj_GUIbox
)
with(c){
	owner = a;
	size_x = 120;
	size_y = 120;
	txt = "BUTTON";
	movable = true;
	clickable = true;
	owner_relative_x = "right";
	owner_relative_y = "bottom";
}

var d = instance_create_depth(
	0,
	0,	
	0,
	obj_GUIbox
)
with(d){
	owner = a;
	size_x = 120;
	size_y = 120;
	txt = "BUTTON";
	movable = true;
	clickable = true;
	owner_relative_x = "left";
	owner_relative_y = "top";
}

var e = instance_create_depth(
	0,
	0,	
	0,
	obj_GUIbox
)
with(e){
	owner = a;
	size_x = 120;
	size_y = 120;
	txt = "BUTTON";
	movable = true;
	clickable = true;
	owner_relative_x = "left";
	owner_relative_y = "bottom";
}

var f = instance_create_depth(
	0,
	0,	
	0,
	obj_GUIbox
)
with(f){
	owner = a;
	size_x = 180;
	size_y = 90;
	size_y_min = 30;
	txt = "BUTTON";
	movable = true;
	clickable = true;
	owner_center_x = true;
	owner_center_y = "true";
	owner_resize_x = true;
	writable = true;
	selectable = true;
	fit_txt_width = false;
	fit_txt_height = true;
	fitdown_txt_height = true;
}






