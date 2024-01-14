global.gui_x = window_get_width();
global.gui_y = window_get_height();
global.gui_scale = 1.2;

ui_object_hoovered = noone;
ui_object_moving = noone;
ui_object_resizing = noone;
ui_object_selected = noone;
ui_object_clicked = noone;

hoover_resizing_left = false;
hoover_resizing_right = false;
hoover_resizing_top = false;
hoover_resizing_bottom = false;


for(var _i = 0; _i < 10; _i += 1){
	global.ui_object_list_layer[_i] = ds_list_create();
}

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
	clickable = false;
	movable = true;
	resizable = true;
	owner_center_x = false;
	owner_center_y = false;
	animation_origin_x = global.gui_x/2;
	animation_origin_y = 0//global.gui_y;
	animation_state = 1;
	animation_origin_scale = 1;
	owner_relative_x = "left";
	owner_relative_y = "top";
	//animation_origin_offset_x = "center";
	//animation_origin_offset_y = "center";
	animation_origin_x_relative = 0;
	animation_origin_y_relative = 0;
}
global.a = a;

var b = instance_create_depth(
	0,
	0,	
	0,
	obj_GUIbox
)
with(b){
	//owner = a;
	ui_depth = 1;
	size_x = 120;
	size_y = 120;
	txt = "BUTTON";
	movable = true;
	clickable = true;
	resizable = true;
	owner_relative_x = "left";
	owner_relative_y = "top";
	owner_resize_y = false;
	clamp_inside_owner = false;
}
global.b = b;
//ds_list_add(global.a.child_ui_object_list,b);

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
	resizable = true;
	clickable = true;
	owner_relative_x = "right";
	owner_relative_y = "top";
	owner_resize_y = false;
}
//ds_list_add(global.a.child_ui_object_list,c);

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
	resizable = true;
	clickable = true;
	owner_relative_x = "left";
	owner_relative_y = "top";
	owner_resize_y = false;
}
ds_list_add(global.a.child_ui_object_list,d);

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
	movable = false;
	resizable = true;
	clickable = true;
	owner_relative_x = "left";
	owner_relative_y = "top";
	owner_resize_y = false;
}
ds_list_add(global.a.child_ui_object_list,e);


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
	//owner_center_x = true;
	//owner_center_y = "true";
	owner_resize_x = true;
	writable = true;
	selectable = true;
	fit_txt_width = false;
	fit_txt_height = true;
	fitdown_txt_height = true;
	owner_resize_y = false;
	
	owner_relative_x = "left";
	owner_relative_y = "top";
}

ds_list_add(global.a.child_ui_object_list,f);


