extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	self.rect_min_size = get_node("VBoxContainer").rect_size
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func setWeather(name:String, odds:int):
	get_node("VBoxContainer/Label").text = name + " " + str(odds) + "%"
	get_node("VBoxContainer/CenterContainer/TextureProgress").value = odds
