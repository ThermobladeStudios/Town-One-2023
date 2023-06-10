extends CharacterBody2D

<<<<<<< HEAD
@export var SPEED = 100
@export var DMG = 20
@export var HEALTH = 100
var DEAD = false
var ATTACKING = false
=======
@export var SPEED = 598
>>>>>>> 557288ccc51ca75a09af2970f04169958ca189b2
@onready var player = get_parent().get_node("Player")
@onready var bambooType = "Bamboo"

func get_Type():
	return bambooType

func _physics_process(delta):
	if DEAD:
		pass
		#Deactive this bamboo
	elif ATTACKING and not DEAD:
		startCombat()
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
	if HEALTH <= 0:
		DEAD = true

func _on_area_2d_body_entered(body):
	if body.get_name() == "Player":
		ATTACKING = true

func _on_area_2d_body_exited(body):
	if body.get_name() == "Player":
		ATTACKING = false
		
func _startCombat():
	pass
	#for every 1second:
	#player.takeDamage(DMG)
	#player.playHurtAnimation()
	#playAttackAnimation() 
