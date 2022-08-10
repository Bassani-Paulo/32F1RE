extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var instructionsLabel = $CenterContainer/InstructionsLabel
var instructionsLabelText: String = ""
const enums = preload("res://Scripts/Enums.gd")

func init(buyPhase:int):
	match buyPhase:
		enums.BuyPhases.GUNSLINGER:
			instructionsLabelText = "Choose a gunslinger"
		_:
			instructionsLabelText = "Opted not for gunslinger"
# Called when the node enters the scene tree for the first time.
func _ready():
	instructionsLabel.text = instructionsLabelText
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
