/*
Automatically generates width based on type of choice, number
of choices, font size, etc.
*/

// for now, we're just using the choice name as its width

draw_set_font(menu_font);
var _buffer = string_height(ATOZ);
var _width = 0;
if (title != undefined) _width = string_width(title);

// width of choices
for (var i = 0; i < ds_list_size(choices); i++) {
	var _choice = choices[|i];
	with (_choice) event_user(1); // event_user(1) sets choice width
	var _choice_width = _choice.width + _buffer;
	if (cursor != undefined) _choice_width += string_width(cursor)*2; // note below
	if (_choice_width > _width) _width = _choice_width;
}

// width of toolbar
if (tooltips) {
	var _toolwidth = _buffer + 10; // 10 is magic number
	if (o_input.using_gamepad) {
		var _spr_s = scr_controller_icon(ds_grid_get(o_input.gamepad_assignment, INPUT.INTERACT, 0));
		var _spr_b = scr_controller_icon(ds_grid_get(o_input.gamepad_assignment, INPUT.BACK, 0));
		if (_spr_s != undefined) _toolwidth += string_width(tool_select) + sprite_get_width(_spr_s);
		if (_spr_b != undefined) _toolwidth += string_width(tool_back) + sprite_get_width(_spr_b);
	} else {
		
	}
	if (_width < _toolwidth) _width = _toolwidth;
}

if (_width < width_min) _width = width_min;

return _width;

/*
The menu width needs to be able to automatically accommodate the width of the choice as 
well as the width of the cursor. The way the menus are displayed, the choices are 
center aligned, and the cursor is left aligned. In order to ensure the cursor still 
looks nice with everything, is to make sure it fits on "both" sides of the center 
aligned choice, hence the * 2.
*/
