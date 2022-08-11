extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var currentScene: Control
# Called when the node enters the scene tree for the first time.
func _ready():
	currentScene = load("res://Scenes/TitleScene.tscn").instance()
	add_child(currentScene)
	var playButton = currentScene.get_node("CenterContainer2/Button")
	playButton.connect("pressed", self, "_on_playButton_pressed")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_playButton_pressed():
	remove_child(currentScene)
	currentScene = load("res://Scenes/StoreScene.tscn").instance()
	currentScene.setup("Choose a gunslinger", testItems[0], testItems[1], testItems[2])
	add_child(currentScene)
	var firstItem = currentScene.get_node("CenterContainer2/HBoxContainer/ItemIconScene1/TextureButton")
	firstItem.connect("pressed", self, "_on_firstItem_pressed")
	pass


func _on_firstItem_pressed():
	remove_child(currentScene)
	currentScene = load("res://Scenes/ItemDescriptionScene.tscn").instance()
	#currentScene.setup()
	add_child(currentScene)





var lightfootMods = [StatMod.new("- Size: 0.5", Enums.Stat.SIZE, Enums.Operation.SET, 0.5), StatMod.new("- Reaction time: 2", Enums.Stat.REACTION_TIME, Enums.Operation.SET, 2)]
var regularMods = [StatMod.new("- Size: 1", Enums.Stat.SIZE, Enums.Operation.SET, 1), StatMod.new("- Reaction time: 0.5", Enums.Stat.REACTION_TIME, Enums.Operation.SET, 0.5)]
var bigGuyMods = [StatMod.new("- Size: 1.5", Enums.Stat.SIZE, Enums.Operation.SET, 1.5), StatMod.new("- Reaction time: 1", Enums.Stat.REACTION_TIME, Enums.Operation.SET, 1)]
var testItems = [Item.new("Lightfoot", lightfootMods), Item.new("Regular", regularMods), Item.new("Big Guy", bigGuyMods)]
