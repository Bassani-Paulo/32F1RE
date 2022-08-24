extends Object

class_name Player

var name:String
var items:Array

var size:float = 1
var reactionTime:float = 1
var reloadTime:float = 1
var repairTime:float = 1
var accuracy:float = 1
var rof:float = 1
var ammoCapacity:int = 1
var bulletSpeed:float = 1
var failChance:float = 1
#var aimTime:float ???

var playerState:int

var reactionTimeRemaining:float
var reloadTimeRemaining:float
var repairTimeRemaining:float
var rofTimeRemaining:float
var deathTimeRemaining:float
var ammoRemaining:int


func _init(nameI:String):
	name = nameI

func setup():
	playerState = Enums.PlayerState.REACTING
	reactionTimeRemaining = reactionTime
	reloadTimeRemaining = 0
	repairTimeRemaining = 0
	rofTimeRemaining = 0
	deathTimeRemaining = -1
	ammoRemaining = ammoCapacity

func setStat(statMod:StatMod):
	match statMod.type:
		Enums.Stat.SIZE:
			size *= statMod.value
		Enums.Stat.REACTION_TIME:
			reactionTime *= statMod.value
		Enums.Stat.RELOAD_TIME:
			reloadTime *= statMod.value
		Enums.Stat.REPAIR_TIME:
			repairTime *= statMod.value
		Enums.Stat.ACCURACY:
			accuracy *= statMod.value
		Enums.Stat.ROF:
			rof *= statMod.value
		Enums.Stat.AMMO_CAPACITY:
			ammoCapacity *= int(statMod.value)
		Enums.Stat.BULLET_SPEED:
			bulletSpeed *= statMod.value
		Enums.Stat.FAIL_CHANCE:
			failChance *= statMod.value


func addItem(item:Item):
	items.append(item)
	for statMod in item.statMods:
		setStat(statMod)


func toString():
	var text = "\n"
	text += "[center][b]" + name + "'s Build[/b][/center]\n\n"
	text += " Items:\n"
	for item in items:
		text += " \t" + item.name + "\n"
	text += "\n"
	text += " Result stats:\n"
	text += " \tSize: [color=maroon]%.2f[/color]  " %size + "standard area\n"
	text += " \tReaction time: [color=maroon]%.2f[/color]  " %reactionTime + "seconds\n"
	text += " \tAccuracy: [color=maroon]%.2f[/color]  " %accuracy + "standard area\n"
	text += " \tRate of Fire: [color=maroon]%.2f[/color]  " %rof + "rounds per second\n"
	text += " \tAmmo capacity: [color=maroon]%.d[/color]  " %ammoCapacity + "rounds\n"
	text += " \tReload time: [color=maroon]%.2f[/color]  " %reloadTime + "seconds\n"
	text += " \tFail chance: [color=maroon]%.2f[/color] " %failChance + "%\n"
	text += " \tRepair time: [color=maroon]%.2f[/color]  " %repairTime + "seconds\n"
	text += " \tBullet speed: [color=maroon]%.2f[/color]  " %bulletSpeed + "seconds\n"
	
	return text
	
	

