extends Object

class_name Item

var icon: Image
var name: String
var statMods: Array

func _init(nameI:String, statModsI:Array):
	#self.icon = icon
	self.name = nameI
	self.statMods = statModsI
