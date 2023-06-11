extends CharacterBody2D


@export var speed = 100
@export var health = 60


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var input_direction = Vector2(Input.get_action_strength("Right") - Input.get_action_strength("Left") , Input.get_action_strength("Down") - Input.get_action_strength("Up")).normalized()
	velocity = input_direction*speed
	move_and_slide()
func _on_area_2d_body_entered(body):
	if("BambooBody" in body.name):
		health -= (JsonData.CharacterData["Bamboo"]["Attack"])
		if health < 0 :
			get_tree().paused = true
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
