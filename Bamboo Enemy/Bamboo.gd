extends CharacterBody2D


@export var SPEED = 100
@export var DMG = 20
@export var HEALTH = 100
var DEAD = false
var ATTACKING = false

@onready var player = get_parent().get_node("Player")
@onready var bambooType = "Bamboo"

func get_Type():
	return bambooType

func _physics_process(delta):
	if DEAD:
		pass
		#Deactive this bamboo
	elif ATTACKING and not DEAD:
		#Execute when the bamboo first reaches the player, and then every 1.5 seconds after.
		_startCombat()
	else:
		findPlayer()

func findPlayer():
	var player_position = player.position
	var target_position = (player_position-position).normalized()
	velocity = target_position*SPEED
	move_and_slide()

func takeDamage(damage):
	HEALTH -= damage
	print("%s took %sdmg" % [self.name, damage])
	print(HEALTH)
	if HEALTH <= 0:
		print("YOu fucking died")
		DEAD = true
		self.queue_free()

func _on_area_2d_body_entered(body):
	if body.get_name() == "Player":
		ATTACKING = true

func _on_area_2d_body_exited(body):
	if body.get_name() == "Player":
		ATTACKING = false
		
func _startCombat():
	pass

