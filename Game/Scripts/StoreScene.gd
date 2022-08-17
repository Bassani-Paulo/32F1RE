extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var instructionsLabel = $VBoxContainer/CenterContainer/InstructionsLabel
var instructionsLabelText: String = ""

func setup(instructions:String, item1:Item, item2:Item, item3:Item, clearOdds:int, sandstormOdds:int, rainOdds:int):
	instructionsLabelText = instructions
	get_node("CenterContainer2/HBoxContainer/ItemIconScene1").setup(item1)
	get_node("CenterContainer2/HBoxContainer/ItemIconScene2").setup(item2)
	get_node("CenterContainer2/HBoxContainer/ItemIconScene3").setup(item3)
	get_node("VBoxContainer/CenterContainer2/VBoxContainer/HBoxContainer/ClearOddsScene").setWeather("Clear", clearOdds)
	get_node("VBoxContainer/CenterContainer2/VBoxContainer/HBoxContainer/SandstormOddsScene").setWeather("Sandstorm", sandstormOdds)
	get_node("VBoxContainer/CenterContainer2/VBoxContainer/HBoxContainer/RainOddsScene").setWeather("Rain", rainOdds)
# Called when the node enters the scene tree for the first time.
func _ready():
	instructionsLabel.text = instructionsLabelText
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
