extends Control

const TU = 0.001

var weather:int
var player:Player
var randomAI:Player
var preTime = 3
var time = 0.0

var showdownLog = ""

func setup(weatherI:int, playerI:Player, ai:Player):
	player = playerI
	randomAI = ai
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
	
	#TROCAR PRA MATCH!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	
	#verificar morte
	
	if player.playerState == Enums.PlayerState.REACTING:
		player.reactionTimeRemaining -= TU
		if player.reactionTimeRemaining <= 0:
			player.playerState == Enums.PlayerState.READY
			showdownLog += player.name + " is ready to shoot.\n"
	if randomAI.playerState == Enums.PlayerState.REACTING:
		randomAI.reactionTimeRemaining -= TU
		if randomAI.reactionTimeRemaining <= 0:
			randomAI.playerState == Enums.PlayerState.READY
			showdownLog += randomAI.name + " is ready to shoot.\n"
	
	#verificar repair
	
	#verificar reload
	
	#verificar rof
	
	#realizar disparo


func _on_PreTimer_timeout():
	if preTime > 0:
		preTime -= 1
		get_node("VBoxContainer/CenterContainer/MarginContainer2/VBoxContainer2/LogLabel").text = "%d" % preTime
	if preTime == 0:
		preTime -= 1
		get_node("ColorRect").visible = true
		get_node("VBoxContainer/CenterContainer/MarginContainer2/VBoxContainer2/LogLabel").add_color_override("font_color", Color(0.08, 0.08, 0.08))
		get_node("PreTimer").stop()
		get_node("Timer").start()
