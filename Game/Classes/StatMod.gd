extends Object

class_name StatMod

var type:int
var isMod:bool
var value:float

var description = "- "

func _init(itemMod:Dictionary):
	
	isMod = itemMod["mod"]
	value = itemMod["value"]
	
	match itemMod["type"]:
		"reaction_time":
			type = Enums.Stat.REACTION_TIME
			if isMod:
				description += "Reaction time modifier: %.2f" %value + "x"
			else:
				description += "Reaction time: %.2f " %value + "seconds"
		"size":
			type = Enums.Stat.SIZE
			if isMod:
				description += "Size modifier: %.2f" %value + "x"
			else:
				description += "Size: %.2f " %value + "standard area"
		"accuracy":
			type = Enums.Stat.ACCURACY
			if isMod:
				description += "Accuracy modifier: %.2f" %value + "x"
			else:
				description += "Accuracy: within %.2f " %value + "standard area"
		"reload_time":
			type = Enums.Stat.RELOAD_TIME
			if isMod:
				description += "Reload time modifier: %.2f" %value + "x"
			else:
				description += "Reload time: %.2f " %value + "seconds"
		"repair_time":
			type = Enums.Stat.REPAIR_TIME
			if isMod:
				description += "Repair time modifier: %.2f" %value + "x"
			else:
				description += "Repair time: %.2f " %value + "seconds"
		"rate_of_fire":
			type = Enums.Stat.ROF
			if isMod:
				description += "Rate of fire modifier: %.2f" %value + "x"
			else:
				description += "Rate of fire: %.2f " %value + "rounds per second"
		"ammo_capacity":
			type = Enums.Stat.AMMO_CAPACITY
			if isMod:
				description += "Ammo capacity modifier: %.2f" %value + "x"
			else:
				description += "Ammo capacity: %d " %value + "rounds"
		"bullet_speed":
			type = Enums.Stat.BULLET_SPEED
			if isMod:
				description += "Bullet speed modifier: %.2f" %value + "x"
			else:
				description += "Bullet speed: %.2f " %value + "seconds"
		"fail_chance":
			type = Enums.Stat.FAIL_CHANCE
			if isMod:
				description += "Fail chance modifier: %.2f" %value + "x"
			else:
				description += "Fail chance: %.2f" %value + "%"
		_:
			print("erro de decodificação de mod")
	

