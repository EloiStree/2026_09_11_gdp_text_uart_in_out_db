
class_name UartIoRelayFilterPackageWithPrefixSuffixFilter
extends Node


@export var _start_end_tag:String="*"


signal on_(device_address:String, message:String)




class SuffixPrefixTag:
	var prefix:String="*"
	var suffix:String="*"

	func _init(_prefix:String, _suffix:String):
		prefix = _prefix
		suffix = _suffix

        

        