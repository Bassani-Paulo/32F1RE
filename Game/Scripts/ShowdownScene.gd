extends Control

const TU = 0.05

const shotSlangs = ["Bang", "Boom", "Pow", "Pew"]

var weather:int
var player:Player
var randomAI:Player
var preTime = 3
var time = 0.0

var showdownLog = "\n"

var rng = RandomNumberGenerator.new()

func setup(weatherI:int, playerI:Player, ai:Player):
	player = playerI
	player.setup()
	randomAI = ai
	randomAI.setup()
	weather = weatherI
	if weather == Enums.Weather.SANDSTORM:
		player.accuracy *= 2
		randomAI.accuracy *= 2
	if weather == Enums.Weather.RAIN:
		player.failChance = 1-((1-player.failChance)*0.2)
		randomAI.failChance = 1-((1-randomAI.failChance)*0.2) 

func _ready():
	match weather:
		Enums.Weather.CLEAR:
			get_node("VBoxContainer/MarginContainer/CenterContainer/HBoxContainer/WeatherLabel").text = "CLEAR"
			get_node("VBoxContainer/MarginContainer/CenterContainer/HBoxContainer/WeatherLabel").add_color_override("font_color", Color("c39425"))
		Enums.Weather.SANDSTORM:
			get_node("VBoxContainer/MarginContainer/CenterContainer/HBoxContainer/WeatherLabel").text = "SANDSTORM"
			get_node("VBoxContainer/MarginContainer/CenterContainer/HBoxContainer/WeatherLabel").add_color_override("font_color", Color("6a634c"))
		Enums.Weather.RAIN:
			get_node("VBoxContainer/MarginContainer/CenterContainer/HBoxContainer/WeatherLabel").text = "RAIN"
			get_node("VBoxContainer/MarginContainer/CenterContainer/HBoxContainer/WeatherLabel").add_color_override("font_color", Color("2261c4"))
	
	get_node("VBoxContainer/CenterContainer/MarginContainer2/VBoxContainer2/LogLabel").text = "%d" % preTime




func _on_Timer_timeout():
	time += TU
	
	if player.deathTimeRemaining >= 0:
		player.deathTimeRemaining -= TU
		if player.deathTimeRemaining <= 0:
			showdownLog += "  %.2f" %time + ": " + player.name + " died.\n"
			get_node("Timer").stop()
			endGame(false)
			return
	
	if randomAI.deathTimeRemaining >= 0:
		randomAI.deathTimeRemaining -= TU
		if randomAI.deathTimeRemaining <= 0:
			showdownLog += "  %.2f" %time + ": " + randomAI.name + " died.\n"
			get_node("Timer").stop()
			endGame(true)
			return
	
	match player.playerState:
		Enums.PlayerState.REACTING:
			player.reactionTimeRemaining -= TU
			if player.reactionTimeRemaining <= 0:
				player.playerState = Enums.PlayerState.READY
				showdownLog += "  %.2f" %time + ": " + player.name + " pulls the trigger.\n"
		Enums.PlayerState.REPARING:
			player.repairTimeRemaining -= TU
			if player.repairTimeRemaining <= 0:
				player.playerState = Enums.PlayerState.READY
				showdownLog += "  %.2f" %time + ": " + player.name + " pulls the trigger.\n"
		Enums.PlayerState.RELOADING:
			player.reloadTimeRemaining -= TU
			if player.reloadTimeRemaining <= 0:
				player.playerState = Enums.PlayerState.READY
				player.ammoRemaining = player.ammoCapacity
				showdownLog += "  %.2f" %time + ": " + player.name + " pulls the trigger.\n"
		Enums.PlayerState.SHOOTING:
			player.rofTimeRemaining -= TU
			if player.rofTimeRemaining <= 0:
				player.playerState = Enums.PlayerState.READY
				showdownLog += "  %.2f" %time + ": " + player.name + " pulls the trigger.\n"
		Enums.PlayerState.READY:
			rng.randomize()
			if rng.randf() <= player.failChance:
				player.playerState = Enums.PlayerState.REPARING
				player.repairTimeRemaining = player.repairTime - TU
				showdownLog += "  %.2f" %time + ": " + player.name + "'s gun jammed.\n"
			else:
				shotAnimation()
				player.ammoRemaining -= 1
				rng.randomize()
				if rng.randf() <= randomAI.size/player.accuracy:
					showdownLog += "  %.2f" %time + ": " + player.name + " shot correctly.\n"
					randomAI.deathTimeRemaining = player.bulletSpeed - TU
				else:
					showdownLog += "  %.2f" %time + ": " + player.name + " misses.\n"
				if player.ammoRemaining <= 0:
					player.playerState = Enums.PlayerState.RELOADING
					player.reloadTimeRemaining = player.reloadTime - TU
					showdownLog += "  %.2f" %time + ": " + player.name + " began reloading.\n"
				else:
					player.playerState = Enums.PlayerState.SHOOTING
					player.rofTimeRemaining = 1.0/player.rof - TU
	
	match randomAI.playerState:
		Enums.PlayerState.REACTING:
			randomAI.reactionTimeRemaining -= TU
			if randomAI.reactionTimeRemaining <= 0:
				randomAI.playerState = Enums.PlayerState.READY
				showdownLog += "  %.2f" %time + ": " + randomAI.name + " pulls the trigger.\n"
		Enums.PlayerState.REPARING:
			randomAI.repairTimeRemaining -= TU
			if randomAI.repairTimeRemaining <= 0:
				randomAI.playerState = Enums.PlayerState.READY
				showdownLog += "  %.2f" %time + ": " + randomAI.name + " pulls the trigger.\n"
		Enums.PlayerState.RELOADING:
			randomAI.reloadTimeRemaining -= TU
			if randomAI.reloadTimeRemaining <= 0:
				randomAI.playerState = Enums.PlayerState.READY
				randomAI.ammoRemaining = randomAI.ammoCapacity
				showdownLog += "  %.2f" %time + ": " + randomAI.name + " pulls the trigger.\n"
		Enums.PlayerState.SHOOTING:
			randomAI.rofTimeRemaining -= TU
			if randomAI.rofTimeRemaining <= 0:
				randomAI.playerState = Enums.PlayerState.READY
				showdownLog += "  %.2f" %time + ": " + randomAI.name + " pulls the trigger.\n"
		Enums.PlayerState.READY:
			rng.randomize()
			if rng.randf() <= randomAI.failChance:
				randomAI.playerState = Enums.PlayerState.REPARING
				randomAI.repairTimeRemaining = randomAI.repairTime - TU
				showdownLog += "  %.2f" %time + ": " + randomAI.name + "'s gun jammed.\n"
			else:
				shotAnimation()
				randomAI.ammoRemaining -= 1
				rng.randomize()
				if rng.randf() <= player.size/randomAI.accuracy:
					showdownLog += "  %.2f" %time + ": " + randomAI.name + " shot correctly.\n"
					player.deathTimeRemaining = randomAI.bulletSpeed - TU
				else:
					showdownLog += "  %.2f" %time + ": " + randomAI.name + " misses.\n"
				if randomAI.ammoRemaining <= 0:
					randomAI.playerState = Enums.PlayerState.RELOADING
					randomAI.reloadTimeRemaining = randomAI.reloadTime - TU
					showdownLog += "  %.2f" %time + ": " + randomAI.name + " began reloading.\n"
				else:
					randomAI.playerState = Enums.PlayerState.SHOOTING
					randomAI.rofTimeRemaining = 1.0/randomAI.rof - TU


func _on_PreTimer_timeout():
	preTime -= 1
	get_node("VBoxContainer/CenterContainer/MarginContainer2/VBoxContainer2/LogLabel").text = "%d" % preTime
	if preTime <= 0:
		get_node("ColorRect").visible = true
		get_node("VBoxContainer/CenterContainer/MarginContainer2/VBoxContainer2/LogLabel").add_color_override("font_color", Color(0.08, 0.08, 0.08))
		get_node("PreTimer").stop()
		get_node("Timer").start()

func endGame(playerWon:bool):
	get_node("VBoxContainer/CenterContainer/MarginContainer2/VBoxContainer2/VBoxContainer").visible = true
	get_node("VBoxContainer/CenterContainer/MarginContainer2/VBoxContainer2/LogLabel").add_color_override("font_color", Color(1,1,1))
	if playerWon:
		get_node("VBoxContainer/CenterContainer/MarginContainer2/VBoxContainer2/LogLabel").text = "You defeated the enemy!"
	else:
		get_node("VBoxContainer/CenterContainer/MarginContainer2/VBoxContainer2/LogLabel").text = "The Enemy defeated you."

func shotAnimation():
	get_node("ColorRect").color = Color(1,1,1)
	get_node("VBoxContainer/MarginContainer/CenterContainer/HBoxContainer/WeatherLabel").visible = false
	rng.randomize()
	get_node("VBoxContainer/CenterContainer/MarginContainer2/VBoxContainer2/LogLabel").text = shotSlangs[rng.randi_range(0,3)]
	get_node("ShotAnimationTime").start()
	


func _on_ShotAnimationTime_timeout():
	get_node("ColorRect").color = Color(0.08, 0.08, 0.08)
	get_node("VBoxContainer/MarginContainer/CenterContainer/HBoxContainer/WeatherLabel").visible = true
