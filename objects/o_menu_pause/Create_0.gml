/// @description Read Parent

// Inherit the parent event
event_inherited();
title = "Game Paused";
border_color = c_purple;

var i = 0;
ds_list_set(choices, i, menu_createchoice(o_choice_back));
with (choices[|i++]) {
	name = "Return To Game";
}
ds_list_set(choices, i, menu_createchoice(o_choice_menu));
with (choices[|i++]) {
	name = "Options";
	submenu = instance_create_depth(0, 0, depth - 1, o_menu_options);
}
ds_list_set(choices, i, menu_createchoice(o_choice_mainmenu));
with (choices[|i++]) {
	name = "Main Menu";
}
ds_list_set(choices, i, menu_createchoice(o_choice_quit));
