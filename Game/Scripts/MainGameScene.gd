extends Control

var currentScene: Control
var previousScene: Control

var rng = RandomNumberGenerator.new()

var clearOdds:int
var sandstormOdds:int
var rainOdds:int

var buyPhase:int
var buyPhaseName:String
var itemsOnSale:Array

var player = Player.new("Player")
var randomAI = Player.new("Enemy")

var itemsFile = File.new()
var items:Array


func _ready():
	
	itemsFile.open("res://items.json", itemsFile.READ)
	items = parse_json(itemsFile.get_as_text())
	itemsFile.close()
	
	currentScene = load("res://Scenes/TitleScene.tscn").instance()
	add_child(currentScene)
	var playButton = currentScene.get_node("CenterContainer2/Button")
	playButton.connect("pressed", self, "_on_playButton_pressed")
	
	setWeatherOdds()





func _on_playButton_pressed():
	buyPhase = -1
	loadStoreScene()

func _on_firstItem_pressed():
	loadItemScene(1)

func _on_secondItem_pressed():
	loadItemScene(2)

func _on_thirdItem_pressed():
	loadItemScene(3)

func _on_confirmButton_pressed():
	player.setStats(currentScene.item.statMods)
	randomAI.setStats(itemsOnSale[rng.randi_range(0, itemsOnSale.size()-1)].statMods)
	if buyPhase%3 == 2:
		loadShowdownScene()
	else:
		loadStoreScene()

func _on_backButton_pressed():
	remove_child(currentScene)
	currentScene = previousScene
	add_child(currentScene)







func loadStoreScene():
	remove_child(currentScene)
	previousScene = currentScene
	currentScene = load("res://Scenes/StoreScene.tscn").instance()
	advanceBuyPhase()
	currentScene.setup("Choose %s" % buyPhaseName, itemsOnSale[0], itemsOnSale[1], itemsOnSale[2], clearOdds, sandstormOdds, rainOdds)
	add_child(currentScene)
	
	var firstItem = currentScene.get_node("CenterContainer2/HBoxContainer/ItemIconScene1/VBoxContainer/TextureButton")
	var secondItem = currentScene.get_node("CenterContainer2/HBoxContainer/ItemIconScene2/VBoxContainer/TextureButton")
	var thirdItem = currentScene.get_node("CenterContainer2/HBoxContainer/ItemIconScene3/VBoxContainer/TextureButton")
	firstItem.connect("pressed", self, "_on_firstItem_pressed")
	secondItem.connect("pressed", self, "_on_secondItem_pressed")
	thirdItem.connect("pressed", self, "_on_thirdItem_pressed")

func loadItemScene(item:int):
	remove_child(currentScene)
	previousScene = currentScene
	currentScene = load("res://Scenes/ItemDescriptionScene.tscn").instance()
	currentScene.setup(itemsOnSale[item-1])
	add_child(currentScene)
	
	var backButton = currentScene.get_node("MarginContainer4/HBoxContainer/BackButton")
	backButton.connect("pressed", self, "_on_backButton_pressed")
	var confirmButton = currentScene.get_node("MarginContainer4/HBoxContainer/ConfirmButton")
	confirmButton.connect("pressed", self, "_on_confirmButton_pressed")

func loadShowdownScene():
	remove_child(currentScene)
	previousScene = currentScene
	currentScene = load("res://Scenes/ShowdownScene.tscn").instance()
	rng.randomize()
	var weather = rng.randf()
	if weather < clearOdds/100.0:
		weather = Enums.Weather.CLEAR
	elif weather < clearOdds/100.0 + sandstormOdds/100.0:
		weather = Enums.Weather.SANDSTORM
	else:
		weather = Enums.Weather.RAIN
	currentScene.setup(weather, player, randomAI)
	add_child(currentScene)



func setWeatherOdds():
	rng.randomize()
	clearOdds = int(100*rng.randf_range(0.5, 0.75))
	sandstormOdds = int(100*rng.randf_range((1-clearOdds/100.0)*0.67, (1-clearOdds/100.0)*0.80))
	rainOdds = int(100-clearOdds-sandstormOdds)

func advanceBuyPhase():
	buyPhase += 1
	match buyPhase:
		Enums.BuyPhases.GUNSLINGER:
			buyPhaseName = "a gunslinger"
			itemsOnSale = testGunslingers
		Enums.BuyPhases.BACKGROUNG:
			buyPhaseName = "a background"
			itemsOnSale = testBackgrounds
		Enums.BuyPhases.WEAPON:
			buyPhaseName = "a weapon"
			itemsOnSale = testWeapons





var lightfootMods = [StatMod.new("- Size: 0.5 standard area", Enums.Stat.SIZE, Enums.Operation.SET, 0.5), StatMod.new("- Reaction time: 2 seconds", Enums.Stat.REACTION_TIME, Enums.Operation.SET, 2)]
var averageMods = [StatMod.new("- Size: 1 standard area", Enums.Stat.SIZE, Enums.Operation.SET, 1), StatMod.new("- Reaction time: 0.5 seconds", Enums.Stat.REACTION_TIME, Enums.Operation.SET, 0.5)]
var bigGuyMods = [StatMod.new("- Size: 1.5 standard area", Enums.Stat.SIZE, Enums.Operation.SET, 1.5), StatMod.new("- Reaction time: 1 seconds", Enums.Stat.REACTION_TIME, Enums.Operation.SET, 1)]
var testGunslingers = [Item.new("Lightfoot", lightfootMods), Item.new("Average", averageMods), Item.new("Big Guy", bigGuyMods)]

var gunsmithMods = [StatMod.new("- Accuracy: within 4 standard area", Enums.Stat.ACCURACY, Enums.Operation.SET, 4), StatMod.new("- Reload Speed modifier: x0.25", Enums.Stat.RELOAD_TIME, Enums.Operation.SET, 0.25), StatMod.new("- Repair Time modifier: x0.25", Enums.Stat.REPAIR_TIME, Enums.Operation.SET, 0.25)]
var regularMods = [StatMod.new("- Accuracy: within 2 standard area", Enums.Stat.ACCURACY, Enums.Operation.SET, 2), StatMod.new("- Reload Speed modifier: x1", Enums.Stat.RELOAD_TIME, Enums.Operation.SET, 1), StatMod.new("- Repair Time modifier: x1", Enums.Stat.REPAIR_TIME, Enums.Operation.SET, 1)]
var shooterMods = [StatMod.new("- Accuracy: within 1.2 standard area", Enums.Stat.ACCURACY, Enums.Operation.SET, 1.2), StatMod.new("- Reload Speed modifier: x2", Enums.Stat.RELOAD_TIME, Enums.Operation.SET, 2), StatMod.new("- Repair Time modifier: x2", Enums.Stat.REPAIR_TIME, Enums.Operation.SET, 2)]
var testBackgrounds = [Item.new("Gunsmith", gunsmithMods), Item.new("Regular", regularMods), Item.new("Shooter", shooterMods)]

var lowCaliberRevolverMods = [StatMod.new("- Rate of Fire: 2 rounds per second", Enums.Stat.ROF, Enums.Operation.SET, 2), StatMod.new("- Reload time: 9 seconds", Enums.Stat.RELOAD_TIME, Enums.Operation.MULTIPLY, 9), StatMod.new("- Ammo Capacity: 6 rounds", Enums.Stat.AMMO_CAPACITY, Enums.Operation.SET, 6), StatMod.new("- Bullet Speed: 0.5 seconds", Enums.Stat.BULLET_SPEED, Enums.Operation.SET, 0.5), StatMod.new("- Fail chance: 10%", Enums.Stat.FAIL_CHANCE, Enums.Operation.SET, 0.1), StatMod.new("- Repair time: 2 seconds", Enums.Stat.REPAIR_TIME, Enums.Operation.MULTIPLY, 2), StatMod.new("- Accuracy modifier: x3", Enums.Stat.ACCURACY, Enums.Operation.MULTIPLY, 3)]
var highCaliberRevolverMods = [StatMod.new("- Rate of Fire: 1 rounds per second", Enums.Stat.ROF, Enums.Operation.SET, 1), StatMod.new("- Reload time: 12 seconds", Enums.Stat.RELOAD_TIME, Enums.Operation.MULTIPLY, 12), StatMod.new("- Ammo Capacity: 5 rounds", Enums.Stat.AMMO_CAPACITY, Enums.Operation.SET, 5), StatMod.new("- Bullet Speed: 0.1 seconds", Enums.Stat.BULLET_SPEED, Enums.Operation.SET, 0.1), StatMod.new("- Fail chance: 10%", Enums.Stat.FAIL_CHANCE, Enums.Operation.SET, 0.1), StatMod.new("- Repair time: 3 seconds", Enums.Stat.REPAIR_TIME, Enums.Operation.MULTIPLY, 3), StatMod.new("- Accuracy modifier: x2", Enums.Stat.ACCURACY, Enums.Operation.MULTIPLY, 2)]
var handShotgunMods = [StatMod.new("- Rate of Fire: 0.33 rounds per second", Enums.Stat.ROF, Enums.Operation.SET, 0.33), StatMod.new("- Reload time: 5 seconds", Enums.Stat.RELOAD_TIME, Enums.Operation.MULTIPLY, 5), StatMod.new("- Ammo Capacity: 2 rounds", Enums.Stat.AMMO_CAPACITY, Enums.Operation.SET, 2), StatMod.new("- Bullet Speed: 1 second", Enums.Stat.BULLET_SPEED, Enums.Operation.SET, 1), StatMod.new("- Fail chance: 20%", Enums.Stat.FAIL_CHANCE, Enums.Operation.SET, 0.2), StatMod.new("- Repair time: 3 seconds", Enums.Stat.REPAIR_TIME, Enums.Operation.MULTIPLY, 3), StatMod.new("- Accuracy modifier: x1", Enums.Stat.ACCURACY, Enums.Operation.MULTIPLY, 1)]
var testWeapons = [Item.new("Low Caliber Revolver", lowCaliberRevolverMods), Item.new("High Caliber Revolver", highCaliberRevolverMods), Item.new("Hand Shotgun", handShotgunMods)]
