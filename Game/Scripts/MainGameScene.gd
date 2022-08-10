extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var currentScene: Control
const enums = preload("res://Scripts/Enums.gd")
# Called when the node enters the scene tree for the first time.
func _ready():
	currentScene = load("res://Scenes/TitleScene.tscn").instance()
	add_child(currentScene)
	var playButton = currentScene.get_node("CenterContainer2").get_node("Button")
	playButton.connect("pressed", self, "_on_Button_pressed")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Button_pressed():
	remove_child(currentScene)
	currentScene = load("res://Scenes/StoreScene.tscn").instance()
	currentScene.init(enums.BuyPhases.BUFF)
	add_child(currentScene)
