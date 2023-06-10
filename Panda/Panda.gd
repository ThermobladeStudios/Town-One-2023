extends CharacterBody2D

@export var SPEED = 100
@onready var player = get_parent().get_node("Player")
@onready var player_radius = 150
var target = null

func _physics_process(delta):
	var player_position = player.position
	var distance_to_player = position.distance_to(player_position)
	
	if distance_to_player > player_radius:
		# Player is outside the radius, so panda should follow player
		target = player_position
	else:
		# Player is inside the radius, so panda should look for Bamboo
		var bamboo_target = find_closest_bamboo()
		if bamboo_target != null:
			target = bamboo_target
		
	if target != null:
		var target_direction = (target - position).normalized()
		velocity = target_direction * SPEED
		move_and_slide()
	else:
		velocity = Vector2.ZERO

func find_closest_bamboo():
	var closest_bamboo = null
	var closest_distance = INF
	var bamboo =  get_parent().get_node("Bamboo")  # Assuming you've added all your Bamboo nodes to a group called "Bamboo"
	var distance = position.distance_to(bamboo.position)
	print('Following bamboo')
	if distance < closest_distance:
		closest_distance = distance
		closest_bamboo = bamboo.position
			
	return closest_bamboo  # Return null if no bamboo is found
