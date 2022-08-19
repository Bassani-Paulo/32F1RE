extends Object

class_name Player

var name:String

var size:float
var reactionTime:float
var reloadTime:float
var repairTime:float
var accuracy:float
var rof:float
var ammoCapacity:int
var bulletSpeed:float
var failChance:float

var playerState:int
var reactionTimeRemaining:float
var reloadTimeRemaining:float
var repairTimeRemaining:float
var rofTimeRemaining:float
var deathTimeRemaining:float
var ammoRemaining:int


func _init(nameI:String):
	name = nameI
	playerState = Enums.PlayerState.REACTING
	reactionTimeRemaining = reactionTime
	reloadTimeRemaining = 0
	repairTimeRemaining = 0
	rofTimeRemaining = 0
	deathTimeRemaining = -1
	ammoRemaining = ammoCapacity

func setStat(statMod:StatMod):
	match statMod.stat:
		Enums.Stat.SIZE:
			match statMod.operation:
				Enums.Operation.SET:
					size = statMod.value
				Enums.Operation.ADD:
					size += statMod.value
				Enums.Operation.MULTIPLY:
					size *= statMod.value
		Enums.Stat.REACTION_TIME:
			match statMod.operation:
				Enums.Operation.SET:
					reactionTime = statMod.value
				Enums.Operation.ADD:
					reactionTime += statMod.value
				Enums.Operation.MULTIPLY:
					reactionTime *= statMod.value
		Enums.Stat.RELOAD_TIME:
			match statMod.operation:
				Enums.Operation.SET:
					reloadTime = statMod.value
				Enums.Operation.ADD:
					reloadTime += statMod.value
				Enums.Operation.MULTIPLY:
					reloadTime *= statMod.value
		Enums.Stat.REPAIR_TIME:
			match statMod.operation:
				Enums.Operation.SET:
					repairTime = statMod.value
				Enums.Operation.ADD:
					repairTime += statMod.value
				Enums.Operation.MULTIPLY:
					repairTime *= statMod.value
		Enums.Stat.ACCURACY:
			match statMod.operation:
				Enums.Operation.SET:
					accuracy = statMod.value
				Enums.Operation.ADD:
					accuracy += statMod.value
				Enums.Operation.MULTIPLY:
					accuracy *= statMod.value
		Enums.Stat.ROF:
			match statMod.operation:
				Enums.Operation.SET:
					rof = statMod.value
				Enums.Operation.ADD:
					rof += statMod.value
				Enums.Operation.MULTIPLY:
					rof *= statMod.value
		Enums.Stat.AMMO_CAPACITY:
			match statMod.operation:
				Enums.Operation.SET:
					ammoCapacity = int(statMod.value)
				Enums.Operation.ADD:
					ammoCapacity += int(statMod.value)
				Enums.Operation.MULTIPLY:
					ammoCapacity *= int(statMod.value)
		Enums.Stat.BULLET_SPEED:
			match statMod.operation:
				Enums.Operation.SET:
					bulletSpeed = statMod.value
				Enums.Operation.ADD:
					bulletSpeed += statMod.value
				Enums.Operation.MULTIPLY:
					bulletSpeed *= statMod.value
		Enums.Stat.FAIL_CHANCE:
			match statMod.operation:
				Enums.Operation.SET:
					failChance = statMod.value
				Enums.Operation.ADD:
					failChance += statMod.value
				Enums.Operation.MULTIPLY:
					failChance *= statMod.value


func setStats(statMods:Array):
	for statMod in statMods:
		setStat(statMod)


func printStats():
	print()
	print()
	print("Name: " + name)
	print()
	print("Size: %.2f   " % size + "standard area")
	print("Reaction time: %.2f   " % reactionTime + "seconds")
	print("Reload time: %.2f   " % reloadTime + "seconds")
	print("Repair time: %.2f   " % repairTime + "seconds")
	print("Accuracy: %.2f   " % accuracy + "standard area")
	print("Rate of Fire: %.2f   " % rof + "rounds per second")
	print("Ammo capacity: %d   " % ammoCapacity + "rounds")
	print("Bullet speed: %.2f   " % bulletSpeed + "seconds")
	print("Fail chance: %.2f" % failChance + "%")
	
	

