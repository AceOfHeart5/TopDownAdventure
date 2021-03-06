/// @description 

event_inherited();

if (input_pressed(INPUT.UI_CLEAR) && submenu.newassignment == undefined) {
	if (o_input.using_gamepad) {
		ds_grid_set(o_input.gamepad_assignment, button, 0, NOASSIGNMENT);
		ds_grid_set(o_input.gamepad_assignment, button, 1, NOASSIGNMENT);
	} else {
		ds_grid_set(o_input.keyboard_assignment, button, 0, NOASSIGNMENT);
		ds_grid_set(o_input.keyboard_assignment, button, 1, NOASSIGNMENT);
	}
	scr_play_sfx(global.sfx_ui_confirm);
}

if (submenu.newassignment != undefined) {
	scr_play_sfx(global.sfx_ui_confirm);
	var _newa = submenu.newassignment;
	/*
	Here we will remap the control. By our design, every remap will
	be one of 3 cases. First, the new assignment is already is 
	assignment slot 1, no change. Second, the new assignment is
	already is slot 2, flip slot one and two. Three, the new
	assignment is not in either slot, assignment in slot 2 is replaced
	by assignment in slot 1, and slot 1 is replaced by the new assignment
	(remember the slots are 0 based)
	
	Also note that we have to resolve any conflicts with existing 
	mappings. We will simply delete the conflict with the current 
	assignment for the action, and then move things around so
	that we don't end up with NOASSIGNMENT in the 1st slot. Luckily,
	it's only in case 3 that we need to worry about this.
	*/
	var _as = o_input.keyboard_assignment;
	if (o_input.using_gamepad) _as = o_input.gamepad_assignment;
	
	// case 1 no code needed
	// case 2
	if (_newa == ds_grid_get(_as, button, 1)) {
		ds_grid_set(_as, button, 1, ds_grid_get(_as, button, 0));
		ds_grid_set(_as, button, 0, _newa);
	}
	// case 3
	if (_newa != ds_grid_get(_as, button, 0) && _newa != ds_grid_get(_as, button, 1)) {
		// delete conflicts
		/*
		Since we redid how we read input in menus, we can't use "size" as our final
		marker for iterating over inputs anymore. We can't have the game check,
		and overwrite the ui inputs. So now, to only iterate over all normal game
		inputs, we have to stop at the first ui input in the enum, which is up. 
		*/
		for (var i = 0; i < INPUT.UI_UP; i++) {
			if (ds_grid_get(_as, i, 0) == _newa) {
				ds_grid_set(_as, i, 0, ds_grid_get(_as, i, 1));
				ds_grid_set(_as, i, 1, NOASSIGNMENT);
			}
			if (ds_grid_get(_as, i, 1) == _newa) ds_grid_set(_as, i , 1, NOASSIGNMENT);
		}
		ds_grid_set(_as, button, 1, ds_grid_get(_as, button, 0));
		ds_grid_set(_as, button, 0, _newa);
	}
	// now reset the button assignment variables
	submenu.newassignment = undefined;
	submenu.choices[|0].newbutton = undefined;
}
