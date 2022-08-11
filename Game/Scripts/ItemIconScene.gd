extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var item:Item

func setup(itemI:Item):
	self.item = itemI

# Called when the node enters the scene tree for the first time.
func _ready():
	#get_node("TextureButton").texture_normal = item.image
	get_node("ItemTitle").text = item.name
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
