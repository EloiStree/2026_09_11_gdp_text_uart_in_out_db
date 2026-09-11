class_name UartIoFormatAddressKeyVariant
extends Node

signal on_formatted_text(formatted_text:String)

@export var _format_key_variant:String="%s:%s:%s"

func push_in_address_key_value_to_format(address:String,key:String, value:Variant):
	var formatted_text = _format_key_variant % [address, key, str(value)]
	on_formatted_text.emit(formatted_text)
