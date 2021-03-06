/// @description Reposition Camera

camera_set_view_size(VIEW_CAMERA, VIEW_W, VIEW_H);

var _x = camera_get_view_x(VIEW_CAMERA) + RESOLUTION_W/2; // treated as center of view
var _y = camera_get_view_y(VIEW_CAMERA) + RESOLUTION_H/2; // treated as center of view

if (global.player != undefined && instance_exists(global.player)) {
	
	// follow player
	switch (follow_type) {
		case CAMFOLLOW.RIGID:
			_x = global.player.x;
			_y = global.player.y;
		break;
		case CAMFOLLOW.BOUNDS:
			while (global.player.x < _x - follow_bound_x) _x--;
			while (global.player.x > _x + follow_bound_x) _x++;
			while (global.player.y < _y - follow_bound_y) _y--;
			while (global.player.y > _y + follow_bound_y) _y++;
		break;
	}
} else {
	_x = 0;
	_y = 0;
}

// change _x/y from center to upper left (how it actually works)
_x = _x - RESOLUTION_W/2;
_y = _y - RESOLUTION_H/2;

// keep camera in bounds
_x = clamp(_x, 0, room_width - RESOLUTION_W);
_y = clamp(_y, 0, room_height - RESOLUTION_H);

camera_set_view_pos(VIEW_CAMERA, _x, _y);
display_set_gui_size(RESOLUTION_W, RESOLUTION_H); // this line does not appear to have done anything
view_set_wport(VIEW_CAMERA, RESOLUTION_W);
view_set_hport(VIEW_CAMERA, RESOLUTION_H);
