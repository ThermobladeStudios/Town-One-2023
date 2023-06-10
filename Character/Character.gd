extends CharacterBody2D

@onready var panda = []
@onready var allpandas = preload("res://Panda/Panda.tscn")
@export var speed = 100
var i = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _ready():
	for x in 3:
		panda.append(allpandas)
		$Timer.start(5)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var input_direction = Vector2(Input.get_action_strength("Right") - Input.get_action_strength("Left") , Input.get_action_strength("Down") - Input.get_action_strength("Up")).normalized()
	velocity = input_direction*speed
	move_and_slide()




func spawn_panda():
	print("Spawn Panda")
	$Panda.add_child(panda[i].instantiate())
	if (i < 2):
		i += 1
	
func _on_timer_timeout():
	spawn_panda()
