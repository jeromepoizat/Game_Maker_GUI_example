
function scr_is_char_letter(_char){
	
	// check if the _character is a letter, so that we can figure out the "bounds" of a word
	// we could use GM's string_letters function, but that function only works for A-Z _characters
	
	return (_char != " " && _char != "	" && _char != "." && _char != "," && _char != ":" && _char != ";" && _char != "<" && _char != ">"
			&& _char != "?" && _char != "!" && _char != "/" && _char != "\\" && _char != "@" && _char != "#" && _char != "$" && _char != "%"
			&& _char != "^" && _char != "&" && _char != "*" && _char != "(" && _char != ")" && _char != "[" && _char != "]" && _char != "{"
			&& _char != "}" && _char != "-" && _char != "=" && _char != "+" && _char != "|");
	
}