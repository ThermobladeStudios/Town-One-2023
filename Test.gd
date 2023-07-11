extends CharacterBody2D


@export var SPEED = 120
@export var DMG = 20
@export var HEALTH = 100


@onready var currPos = self.position

@export var movement_target: Node2D
@export var navigation_agent: NavigationAgent2D
var new_velocity : Vector2
func _ready():
	navigation_agent.path_desired_distance = 10.0
	navigation_agent.target_desired_distance = 50.0



func _physics_process(delta):
	actor_setup()
	if navigation_agent.is_navigation_finished():
		return
	
	var current_agent_position: Vector2 = global_position
	var next_path_position: Vector2 = navigation_agent.get_next_path_position()
	new_velocity = next_path_position - current_agent_position
	new_velocity = new_velocity.normalized()
	new_velocity = new_velocity.round()
	
	velocity = new_velocity * SPEED
	move_and_slide()


	
	
func actor_setup():
	await get_tree().physics_frame
	set_movement_target(movement_target.position)


func set_movement_target(target_point: Vector2):
	navigation_agent.target_position = target_point
	

