extends Label

func _ready():
	var RNG = RandomNumberGenerator.new()
	text = str(RNG.randi_range(1, 6))
