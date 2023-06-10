extends CharacterBody2D


@export var speed = 100


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var input_direction = Vector2(Input.get_action_strength("Right") - Input.get_action_strength("Left") , Input.get_action_strength("Down") - Input.get_action_strength("Up")).normalized()
	velocity = input_direction*speed
	move_and_slide()
