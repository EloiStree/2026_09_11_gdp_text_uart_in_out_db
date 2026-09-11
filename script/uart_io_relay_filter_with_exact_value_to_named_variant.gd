class_name UartIoRelayFilterWithExactValueToNamedVariant
extends Node


signal on_bool_value_found_with_address(address: String, named: String, value: bool)
signal on_trigger_found_with_address(address: String, trigger: String)
signal on_bool_value_found(named: String, value: bool)
signal on_trigger_found( trigger: String)




@export_multiline() var _add_at_ready:String="""FILE>>>|default.uart_to_ab_input

P0♦️true♦️pin0
p0♦️false♦️pin0
P1♦️true♦️pin1
p1♦️false♦️pin1
P2♦️true♦️pin2
p2♦️false♦️pin2

A♦️true♦️BUTTON_A
a♦️false♦️BUTTON_A
B♦️true♦️BUTTON_B
b♦️false♦️BUTTON_B
L♦️true♦️BUTTON_LOGO
l♦️false♦️BUTTON_LOGO


LOUD♦️trigger♦️SOUND_LOUD
quiet♦️trigger♦️SOUND_QUIET

EVS3G♦️trigger♦️SHAKE_3G
EVS6G♦️trigger♦️SHAKE_6G
EVS8G♦️trigger♦️SHAKE_8G

EVSHAKE♦️trigger♦️SHAKE

EVSU♦️trigger♦️SCREEN_UP
EVSD♦️trigger♦️SCREEN_DOWN

EVLU♦️trigger♦️LOGO_UP
EVLD♦️trigger♦️LOGO_DOWN

EVFALL♦️trigger♦️FALL

EVTL♦️trigger♦️TILT_LEFT
EVTR♦️trigger♦️TILT_RIGHT	

"""


@export var _value_to_trigger:Dictionary[String, String] = {}
@export var _value_to_named_value_true:Dictionary[String, String] = {}
@export var _value_to_named_value_false:Dictionary[String, String] = {}


func _ready() -> void:
	_value_to_named_value_true.clear()
	_value_to_named_value_false.clear()
	_value_to_trigger.clear()
	append_boolean_trigger_from_text(_add_at_ready)


func append_boolean_value_true(value_to_find: String, named_of_variable:String) -> void:
	_value_to_named_value_true[value_to_find.strip_edges()] = named_of_variable

func append_boolean_value_false(value_to_find: String, named_of_variable:String) -> void:
	_value_to_named_value_false[value_to_find.strip_edges()] = named_of_variable

func append_trigger_value(value_to_find: String, trigger_name:String) -> void:
	_value_to_trigger[value_to_find.strip_edges()] = trigger_name


func append_boolean_trigger_from_text(text_to_import: String) -> void:
	var lines = text_to_import.split("\n", false)
	for line in lines:
		var parts = line.split("♦️", false)
		if parts.size() == 3:
			var value_to_find = parts[0].strip_edges()
			var type = parts[1].strip_edges().to_lower()
			var named = parts[2].strip_edges()
			if type == "true":
				append_boolean_value_true(value_to_find, named)
			elif type == "false":
				append_boolean_value_false(value_to_find, named)
			elif type == "trigger":
				append_trigger_value(value_to_find, named)


func push_in_address_value(address: String, value: String) -> void:
	value = value.strip_edges()
	if _value_to_named_value_true.has(value):
		on_bool_value_found_with_address.emit(address, _value_to_named_value_true[value], true)
		on_bool_value_found.emit(_value_to_named_value_true[value], true)
	elif _value_to_named_value_false.has(value):
		on_bool_value_found_with_address.emit(address, _value_to_named_value_false[value], false)
		on_bool_value_found.emit(_value_to_named_value_false[value], false)
	elif _value_to_trigger.has(value):
		var trigger_name = _value_to_trigger[value]
		on_trigger_found_with_address.emit(address, trigger_name)
		on_trigger_found.emit(trigger_name)
		# print("Trigger found for value: ", value, " with trigger name: ", trigger_name)
		# print("Address for trigger: ", address, " with trigger name: ", trigger_name)
