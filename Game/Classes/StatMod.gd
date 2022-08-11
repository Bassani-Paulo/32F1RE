extends Object

class_name StatMod

var description: String
var stat:int
var operation:int
var value:float

func _init(descriptionI:String, statI:int, operationI:int, valueI:float):
	self.description = descriptionI
	self.stat = statI
	self.operation = operationI
	self.value = valueI
