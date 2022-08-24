extends Object

class_name Item

var icon: Image
var type: int
var name: String
var statMods: Array

func _init(item:Dictionary):
	#self.icon = icon
	match item["type"]:
		"gunslinger":
			type = Enums.ItemTypes.GUNSLINGER
		"background":
			type = Enums.ItemTypes.BACKGROUND
		"weapon":
			type = Enums.ItemTypes.WEAPON
		_:
			print("erro de decodificação de item")
	
	name = item["name"]
	
	for i in item["mods"]:
		var mod = StatMod.new(i)
		statMods.append(mod)
