extends Label


	
# Called when the node enters the scene tree for the first time.
func _ready():
	var num_gen = RandomNumberGenerator.new()
	var rand_num = num_gen.randf_range(-5.0,5.0)
	set_text(str(num_gen))

	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
