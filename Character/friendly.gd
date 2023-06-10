extends Node2D

@onready var panda = []
@onready var allpandas = preload("res://Panda/Panda.tscn")
var i = 0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _ready():
	for x in 3:
		panda.append(allpandas)
		$Timer.start(5)
	

func spawn_panda():
	$Pandas.add_child(panda[i].instantiate())
	i += 1
func _on_timer_timeout():
	spawn_panda()
