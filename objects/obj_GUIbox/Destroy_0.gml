/// @description destroy ui object

var _pos = ds_list_find_value(global.ui_object_list_layer[ui_depth], real(id));
ds_list_delete(global.ui_object_list_layer[ui_depth], _pos);
