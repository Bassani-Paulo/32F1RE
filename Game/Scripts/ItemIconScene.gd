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
	var rng = RandomNumberGenerator.new()
	var noise = OpenSimplexNoise.new()
	noise.octaves = 2
	noise.period = 50
	rng.randomize()
	noise.seed = rng.randi_range(0, 27)
	var texture = NoiseTexture.new()
	texture.noise = noise
	texture.width = 200
	texture.height = 200
	get_node("VBoxContainer/TextureButton").texture_normal = texture
	var a
	rng.randomize()
	a = rng.randf()
	var b
	rng.randomize()
	b = rng.randf()
	var c
	rng.randomize()
	c = rng.randf()
	rng.randomize()
	match rng.randi_range(0,2):
		0:
			get_node("VBoxContainer/TextureButton").modulate = Color(a,b,c)
		1:
			get_node("VBoxContainer/TextureButton").modulate = Color(b,c,a)
		2:
			get_node("VBoxContainer/TextureButton").modulate = Color(c,a,b)
	
	get_node("VBoxContainer/ItemTitle").text = item.name
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
