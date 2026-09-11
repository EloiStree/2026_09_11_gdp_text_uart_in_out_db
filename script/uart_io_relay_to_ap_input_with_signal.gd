class_name UartIoRelayToApInputWithSignal
extends Node


signal on_relay_to_ap_input_trigger(key_name: String, value: String)
signal on_relay_to_ap_input_boolean(key_name: String, value: bool)
signal on_relay_to_ap_input_float(key_name: String, value: float)


@export var _format_address_key_as_name: String = "uart|%s|%s"
@export var _format_key_as_name: String = "uart|%s"


func push_to_ap_input_trigger(key_name: String, value: String) -> void:
	var formatted_key_name = _format_key_as_name % [key_name]
	on_relay_to_ap_input_trigger.emit(formatted_key_name, value)

func push_to_ap_input_boolean(key_name: String, value: bool) -> void:
	var formatted_key_name = _format_key_as_name % [key_name]
	on_relay_to_ap_input_boolean.emit(formatted_key_name, value)

func push_to_ap_input_float(key_name: String, value: float) -> void:
	var formatted_key_name = _format_key_as_name % [key_name]
	on_relay_to_ap_input_float.emit(formatted_key_name, value)


func push_to_ap_input_trigger_with_address(address:String, key_name: String, value: String) -> void:
	var formatted_key_name = _format_address_key_as_name % [address, key_name]
	on_relay_to_ap_input_trigger.emit(formatted_key_name, value)

func push_to_ap_input_boolean_with_address(address:String, key_name: String, value: bool) -> void:
	var formatted_key_name = _format_address_key_as_name % [address, key_name]
	on_relay_to_ap_input_boolean.emit(formatted_key_name, value)

func push_to_ap_input_float_with_address(address:String, key_name: String, value: float) -> void:
	var formatted_key_name = _format_address_key_as_name % [address, key_name]
	on_relay_to_ap_input_float.emit(formatted_key_name, value)
