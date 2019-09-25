/// @param text

ds_list_clear(lines);

var _width_max = width - text_offset*2;
var _height_max = height - text_offset*2;

draw_set_font(font); // need this to determine string pixel length

var _c;
var _word = "";
var _line = "";

for (var i = 1; i <= string_length(argument[0]); i++) {
	_c = string_char_at(argument[0], i);
	_word += _c;
	if (_c == " ") {
		if (string_width(_line + _word) <= _width_max) _line += _word;
		else {
			ds_list_add(lines, _line);
			_line = _word;
		}
	}
}

ds_list_add(lines, _line);

if (ds_list_size(lines) * string_height(ATOZ) > _height_max) {
	ds_list_clear(lines);
	ds_list_add("ERROR: Too much text!");
}