// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function print(){
    var _str = "";

    for (var _i = 0; _i < argument_count; _i++)
    {
        _str += string(argument[_i]);
    }

    show_debug_message(_str);
}