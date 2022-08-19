extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var item:Item

func setup(itemI:Item):
	item = itemI
	get_node("VBoxContainer/MarginContainer3/ItemIconScene").setup(item)
	for i in item.statMods.size():
		get_node("VBoxContainer/MarginContainer2/StatsContainer/Label%d" % i).text = item.statMods[i].description
		get_node("VBoxContainer/MarginContainer2/StatsContainer/Label%d" % i).visible = true
	
	

# Called when the node enters the scene tree for the first time.
func _ready():
	var font = DynamicFont.new()
	font.font_data = load("res://Fonts/Hack-Bold.ttf")
	font.size = 36
	get_node("VBoxContainer/MarginContainer3/ItemIconScene/VBoxContainer/ItemTitle").add_font_override("font", font)
	
	
	get_node("VBoxContainer/MarginContainer3/ItemIconScene/VBoxContainer/TextureButton").rect_min_size.x *= 2
	get_node("VBoxContainer/MarginContainer3/ItemIconScene/VBoxContainer/TextureButton").rect_min_size.y *= 2
	yield(get_tree(), "idle_frame")
	get_node("VBoxContainer/MarginContainer3/ItemIconScene/VBoxContainer/TextureButton").rect_scale.x = 2
	get_node("VBoxContainer/MarginContainer3/ItemIconScene/VBoxContainer/TextureButton").rect_scale.y = 2
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
