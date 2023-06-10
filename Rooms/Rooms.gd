extends Node2D

var RNG = RandomNumberGenerator.new()
var DoorsOpen = [0, 0, 0, 0]

func _ready():
	var Doors = [$Door1, $Door2, $Door3, $Door4]
	DoorsOpen[RNG.randi_range(0, 3)] = 1
	for x in range(DoorsOpen.size()):
		if DoorsOpen[x] != 1 and RNG.randi_range(1, 4) == 1:
			DoorsOpen[x] = 1

	for x in range(DoorsOpen.size()):
		print(Doors)
		if DoorsOpen[x] == 1:
			Doors[x].get_node("CollisionShape2D").disabled = false
		else:
			Doors[x].get_node("CollisionShape2D").disabled = true
