extends CharacterBody2D

@export var SPEED = 598
@onready var player = get_parent().get_node("Player")
@onready var bambooType = "Bamboo"

func get_Type():
	return bambooType

func _physics_process(delta):
	var player_position = player.position
	var target_position = (player_position-position).normalized()
	velocity = target_position*SPEED
	move_and_slide()
