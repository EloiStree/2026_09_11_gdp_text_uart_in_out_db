class_name UartIoGateOutRelay
extends Node


signal on_request_to_send_message_to_address(device_address:String, message:String)

@export var _last_send_address:String
@export var _last_send_message:String

func relay_text_to_send_to_address(device_address:String, message:String ):
	_last_send_address = device_address
	_last_send_message = message
	on_request_to_send_message_to_address.emit(device_address,message)
	
