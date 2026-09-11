class_name UartIoFormatAddressMessage
extends Node


signal on_formatted_text(text:String)

@export var format:String = "%s:%s"
@export var _last_formatted_text:String = ""

func push_in_text_with_address(address:String, message:String):
	var t = format % [address, message]
	_last_formatted_text = t
	on_formatted_text.emit(t)
	

func push_in_variant_with_address(address:String, message:Variant):
	var t = format % [address,str(message)]
	_last_formatted_text = t
	on_formatted_text.emit(t)
