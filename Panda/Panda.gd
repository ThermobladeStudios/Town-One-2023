extends CharacterBody2D

@export var SPEED = 100
@onready var player = get_parent().get_parent().get_node("Player")
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
	for bamboo in get_tree().get_nodes_in_group("Bamboo"):  # Assuming you've added all your Bamboo nodes to a group called "Bamboo"
			var distance = position.distance_to(bamboo.position)
			if distance < closest_distance:
				closest_distance = distance
				closest_bamboo = bamboo.position
			
	return closest_bamboo  # Return null if no bamboo is found

	
@export var health = 100
@export var attack = 10
@export var attack_range = 50
@onready var attack_area = $Area2D
var target_bamboo = null

func _ready():
	attack_area.connect("body_entered", Callable(self, "_on_Bamboo_entered"))
	attack_area.connect("body_exited", Callable(self, "_on_Bamboo_exited"))

func _on_Bamboo_entered(body):
	if body.get_name() == "Bamboo":
		target_bamboo = body
		start_combat()

func _on_Bamboo_exited(body):
	if body == target_bamboo:
		target_bamboo = null
		stop_combat()

func start_combat():
	print("Starting combat")
#	show_attack()

func stop_combat():
	print("Stopping combat")
	


@onready var attack_label = $AttackLabel
@onready var attack_tween = get_tree().create_tween()

func show_attack():
	attack_label.text = "-%d hp" % attack
	attack_label.show()
	
	print(attack_label)
	print(attack_label.rect_position, attack_label.rect_position + Vector2(0, -50))  # should not be the same
	print(attack_label.modulate, Color(0, 0, 0, 0))  # should not be the same


	# Animate label to make it float upwards and disappear
	attack_tween.interpolate_property(attack_label, "rect_position", attack_label.rect_position, attack_label.rect_position + Vector2(0, -50), 1, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	attack_tween.interpolate_property(attack_label, "modulate", attack_label.modulate, Color(0, 0, 0, 0), 1, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	attack_tween.start()
#	await(attack_tween, "tween_completed")
	attack_label.hide()
	attack_label.rect_position = Vector2(0, 0)  # Reset label position


	
