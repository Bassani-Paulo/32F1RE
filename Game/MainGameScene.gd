extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var currentScene: Control

# Called when the node enters the scene tree for the first time.
func _ready():
	currentScene = load("res://TitleScene.tscn").instance()
	add_child(currentScene)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
