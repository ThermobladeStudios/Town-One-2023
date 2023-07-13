extends CharacterBody2D

@export var SPEED = 100
@onready var player = get_parent().get_parent().get_node("Player")
@onready var player_radius = 100
var target = null
@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")
@onready var state = 0
#0 is idle 1 is walking 2 is attacking
func _ready():
	attack_area.connect("body_entered", Callable(self, "_on_Bamboo_entered"))
	attack_area.connect("body_exited", Callable(self, "_on_Bamboo_exited"))

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
	pick_new_state()
	if target != null:
		var target_direction = (target - position).normalized()
		velocity = target_direction * SPEED
		update_animation_parameters(target_direction)
		move_and_slide()
	else:
		velocity = Vector2.ZERO
		move_and_slide()
func find_closest_bamboo():
	var closest_bamboo = null
	var closest_distance = INF
	for bamboo in get_tree().get_nodes_in_group("Bamboo"):  # Assuming you've added all your Bamboo nodes to a group called "Bamboo"
			var distance = position.distance_to(bamboo.position)
			if distance < closest_distance:
				closest_distance = distance
				closest_bamboo = bamboo.position
			
	return closest_bamboo  # Return null if no bamboo is found

	
func update_animation_parameters(move_input : Vector2):	
	if(move_input != Vector2.ZERO):
		animation_tree.set("parameters/Walk/blend_position", move_input)
	elif(state == 2):
		velocity = Vector2.ZERO
func pick_new_state():

	if(state == 1):
		state_machine.travel("Walk")
	elif(state == 2):
		state_machine.travel("Attack")



@export var health = 100
@export var attack = 10
@export var attack_range = 50
@onready var attack_area = $Area2D
var target_bamboo = null
var pandaType = "Hero Panda"






func start_combat(monster):
	var attack = JsonData.CharacterData["Bamboo"]["Attack"]
	$TimerH.wait_time = JsonData.CharacterData[pandaType]["CoolDown"]
	monster.takeDamage(attack)
	$Attack_cooldown.start(2)
	

	
func _on_area_2d_body_entered(body):
	
	if "BambooBody" in body.name:
		target_bamboo = body.get_Type()
		$attack_timer.start()
		state = 2
		start_combat(body)





func _on_attack_timer_timeout():
	state = 1
	$attack_timer.stop()


func _on_attack_cooldown_timeout():
	target_bamboo = null
	$Attack_cooldown.stop()


func _on_area_2d_body_exited(body):
	pass # Replace with function body.
