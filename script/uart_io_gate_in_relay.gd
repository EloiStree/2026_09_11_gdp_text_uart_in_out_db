class_name UartIoGateInRelay
extends Node


signal on_relay_received_message_from_address(device_address:String, message:String)
signal on_relay_received_only_address(address:String)
signal on_relay_received_only_text(text:String)
@export var _last_send_address:String
@export var _last_send_message:String

func relay_text_received_from_address(device_address:String, message:String ):
	_last_send_address = device_address.strip_edges()
	_last_send_message = message.strip_edges()
	on_relay_received_message_from_address.emit(device_address,message)
	
	on_relay_received_only_address.emit(device_address)
	on_relay_received_only_text.emit(message)
	
