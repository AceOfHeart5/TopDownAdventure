/// @description 

if (timed) {
	if (time >= time_max) instance_destroy(id);
	else time++;
} else if (image_index >= image_number - 1) instance_destroy(id);