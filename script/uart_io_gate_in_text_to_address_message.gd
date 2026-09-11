class_name UartIoGateInTextToAddressMessage

extends Node

signal on_found_address_message_from_text(address: String, message: String)
signal on_received_text_to_split(raw_text_received: String)

@export var _valide_if_start_with: Array[String] = ["uart|"]
@export var _split_delimiter: String = "|"


@export var _last_received: String
@export var _last_address: String
@export var _last_message: String


func push_in_text_to_split(text: String) :
	if text.is_empty():
		return
	on_received_text_to_split.emit(text)
	for prefix in _valide_if_start_with:
		if text.begins_with(prefix):
			var parts = text.split(_split_delimiter)
			if parts.size() >= 3:
				var address = parts[1].strip_edges()
				var message = parts[2].strip_edges()
				_last_received = text
				_last_address = address
				_last_message = message
				on_found_address_message_from_text.emit( address, message)
			break
