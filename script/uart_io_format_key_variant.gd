class_name UartIoFormatKeyVariant
extends Node
signal on_formatted_text(formatted_text:String)
@export var _format_key_variant:String="%s:%s"

func push_in_key_value_to_format(key:String, value:Variant):
	var formatted_text = _format_key_variant % [key,str(value)]
	on_formatted_text.emit(formatted_text)
