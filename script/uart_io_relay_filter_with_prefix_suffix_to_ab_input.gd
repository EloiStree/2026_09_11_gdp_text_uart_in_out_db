
class_name UartIoRelayFilterWithPrefixSuffixToAbInput
extends Node


signal on_any_value_found_striped(device_address:String, variable_name:String, message_striped:String)

signal on_bool_value_found_with_address(device_address:String, variable_name:String, found_value:bool)
signal on_float_value_found_with_address(device_address:String, variable_name:String, found_value:float)
signal on_trigger_value_found_with_address(device_address:String, variable_name:String, message_striped:String)

signal on_bool_value_found( variable_name:String, found_value:bool)
signal on_float_value_found( variable_name:String, found_value:float)
signal on_trigger_value_found( variable_name:String, message_striped:String)
signal on_no_parser_found(device_address:String, message:String)

var _parser_list:Array[PrefixSuffixTag] = []

@export_multiline var _add_at_ready:String="""FILE>>>|default.uart_to_ab_input
prefix♦️suffix♦️name_of_value
*GF♦️*♦️name_of_value
*OB♦️*♦️name_of_value
*EV♦️*♦️name_of_value
"""


@export var _value_for_true:Array[String] = ["true", "t", "on"]
@export var _value_for_false:Array[String] = ["false", "f", "off"]

func is_true_or_false(value:String) -> bool:
	return value in _value_for_true or value in _value_for_false

func get_bool_value(value:String) -> bool:
	return value in _value_for_true

func _ready():
	append_parsers_from_string(_add_at_ready)

func append_parser(prefix:String, suffix:String, name_of_value:String):
	var parser = PrefixSuffixTag.new(prefix, suffix, name_of_value)
	_parser_list.append(parser)

func append_parsers_from_string(data:String):
	var lines = data.split("\n", false)
	for line in lines:
		var parts = line.split("♦️", false)
		if parts.size() == 3:
			append_parser(parts[0], parts[1], parts[2])
		

func push_in_package_to_parse(address:String, message:String):
	var found_parser:bool = false
	for parser in _parser_list:
		if message.begins_with(parser.get_prefix()) and message.ends_with(parser.get_suffix()):
			found_parser = true
			var striped_message = message.substr(parser.get_prefix().length(), message.length() - parser.get_prefix().length() - parser.get_suffix().length())
			on_any_value_found_striped.emit(address, parser.get_name_of_value(), striped_message)
			if is_true_or_false(striped_message):
				var bool_value = get_bool_value(striped_message)
				on_bool_value_found_with_address.emit(address, parser.get_name_of_value(), bool_value)    
				on_bool_value_found.emit(parser.get_name_of_value(),bool_value)

			elif striped_message.is_valid_int():
				on_float_value_found_with_address.emit( address, parser.get_name_of_value(), float(striped_message.to_int()))
				on_float_value_found.emit(parser.get_name_of_value(), float(striped_message.to_int()))
			elif striped_message.is_valid_float():
				on_float_value_found_with_address.emit( address, parser.get_name_of_value(), striped_message.to_float())
				on_float_value_found.emit(parser.get_name_of_value(), striped_message.to_float())
			else:
				on_trigger_value_found.emit(address, parser.get_name_of_value(), striped_message)
				on_trigger_value_found.emit(parser.get_name_of_value(), striped_message)

	if not found_parser:
		on_no_parser_found.emit(address, message)




class PrefixSuffixTag:
	var _prefix:String="*"
	var _suffix:String="*"
	var _name_of_value:String=""

	func get_prefix() -> String:
		return _prefix

	func get_suffix() -> String:
		return _suffix

	func get_name_of_value() -> String:
		return _name_of_value

	func _init(prefix:String, suffix:String, name_of_value:String):
		_prefix = prefix
		_suffix = suffix
		_name_of_value = name_of_value
