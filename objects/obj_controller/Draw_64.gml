/// @description Draw UI
// You can write your code in this editor

var _ui_object_list;
var _ui_object;
var _j
var _break_loop_layers = false;
for(var _i = 0; _i <= 9; _i += 1){
	_ui_object_list = global.ui_object_list_layer[_i];
		
	//loop all ui objects of that layer
	var _ui_object_list_size = ds_list_size(_ui_object_list);
	_j = 0;
	repeat(_ui_object_list_size){
		_ui_object = ds_list_find_value(_ui_object_list, _j);
		_j += 1;
		if _ui_object.visible {
			with(_ui_object){
				if ui_surface_to_draw_on == noone {
					scr_ui_draw();
				}
			}
		}
	}
}


