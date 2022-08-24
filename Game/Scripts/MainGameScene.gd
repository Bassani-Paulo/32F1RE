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
var gunslingers:Array
var backgrounds:Array
var weapons:Array


func _ready():
	
	itemsFile.open("res://items.json", itemsFile.READ)
	items = parse_json(itemsFile.get_as_text())
	itemsFile.close()
	
	for i in items:
		var item = Item.new(i)
		match item.type:
			Enums.ItemTypes.GUNSLINGER:
				gunslingers.append(item)
			Enums.ItemTypes.BACKGROUND:
				backgrounds.append(item)
			Enums.ItemTypes.WEAPON:
				weapons.append(item)
	
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
	player.addItem(currentScene.item)
	rng.randomize()
	match currentScene.item.type:
		Enums.ItemTypes.GUNSLINGER:
			randomAI.addItem(gunslingers[rng.randi_range(0, gunslingers.size()-1)])
		Enums.ItemTypes.BACKGROUND:
			randomAI.addItem(backgrounds[rng.randi_range(0, backgrounds.size()-1)])
		Enums.ItemTypes.WEAPON:
			randomAI.addItem(weapons[rng.randi_range(0, weapons.size()-1)])
	
	if buyPhase%3 == 2:
		loadShowdownScene()
	else:
		loadStoreScene()

func _on_backButton_pressed():
	remove_child(currentScene)
	currentScene = previousScene
	add_child(currentScene)

func _on_playAgainButton_pressed():
	buyPhase = -1
	player = Player.new("Player")
	randomAI = Player.new("Enemy")
	setWeatherOdds()
	loadStoreScene()

func _on_battleLogButton_pressed():
	loadTextShowerScene(currentScene.showdownLog)
func _on_yourItemsButton_pressed():
	loadTextShowerScene(player.toString())
func _on_enemyItemsButton_pressed():
	loadTextShowerScene(randomAI.toString())




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
	
	
	var yourItemsButton = currentScene.get_node("VBoxContainer/CenterContainer/MarginContainer2/VBoxContainer2/VBoxContainer/YourItemsButton")
	yourItemsButton.connect("pressed", self, "_on_yourItemsButton_pressed")
	var enemyItemsButton = currentScene.get_node("VBoxContainer/CenterContainer/MarginContainer2/VBoxContainer2/VBoxContainer/EnemyItemsButton")
	enemyItemsButton.connect("pressed", self, "_on_enemyItemsButton_pressed")
	var battleLogButton = currentScene.get_node("VBoxContainer/CenterContainer/MarginContainer2/VBoxContainer2/VBoxContainer/BattleLogButton")
	battleLogButton.connect("pressed", self, "_on_battleLogButton_pressed")
	var playAgainButton = currentScene.get_node("VBoxContainer/CenterContainer/MarginContainer2/VBoxContainer2/VBoxContainer/PlayAgainButton")
	playAgainButton.connect("pressed", self, "_on_playAgainButton_pressed")

func loadTextShowerScene(text:String):
	remove_child(currentScene)
	previousScene = currentScene
	currentScene = load("res://Scenes/TextShower.tscn").instance()
	currentScene.setup(text)
	add_child(currentScene)
	
	var backButton = currentScene.get_node("MarginContainer/VBoxContainer/CenterContainer/BackButton")
	backButton.connect("pressed", self, "_on_backButton_pressed")


func setWeatherOdds():
	rng.randomize()
	clearOdds = int(100*rng.randf_range(0.5, 0.75))
	sandstormOdds = int(100*rng.randf_range((1-clearOdds/100.0)*0.67, (1-clearOdds/100.0)*0.80))
	rainOdds = int(100-clearOdds-sandstormOdds)

func advanceBuyPhase():
	buyPhase += 1
	randomize()
	match buyPhase:
		Enums.BuyPhases.GUNSLINGER:
			buyPhaseName = "a gunslinger"
			gunslingers.shuffle()
			itemsOnSale = gunslingers
		Enums.BuyPhases.BACKGROUNG:
			buyPhaseName = "a background"
			backgrounds.shuffle()
			itemsOnSale = backgrounds
		Enums.BuyPhases.WEAPON:
			buyPhaseName = "a weapon"
			weapons.shuffle()
			itemsOnSale = weapons
