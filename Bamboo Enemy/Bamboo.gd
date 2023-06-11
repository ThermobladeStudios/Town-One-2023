extends CharacterBody2D


@export var SPEED = 120
@export var DMG = 20
@export var HEALTH = 100
var DEAD = false
var ATTACKING = false
var RNG = RandomNumberGenerator.new()
var KNOCKBACKSTRENGTH = -500
var knockback: Vector2 = Vector2.ZERO
var knockbackTween

@onready var player = get_parent().get_node("Player")
@onready var bambooType = "Bamboo"
@onready var world = player.get_parent()

@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")
@onready var state = 0

#0 is idle 1 is walking 2 is attacking

func get_Type():
	return bambooType

func _ready():
	$ProgressBar.max_value = HEALTH
	player.on_knockback.connect(self.knockback_handler)
	$Spawn.start(1)
	
func knockback_handler():
	var player_position = player.position
	var target_position = (player_position-position).normalized()
	_hit(target_position*KNOCKBACKSTRENGTH)

func _process(delta):
	$ProgressBar.value = HEALTH

func _physics_process(delta):
	if(state != 0):
		findPlayer()



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





func findPlayer():
	var player_position = player.position
	var target_position = (player_position-position).normalized()
	velocity = target_position*SPEED + knockback
	update_animation_parameters(target_position)
	pick_new_state()
	move_and_slide()

func _hit(knockback_strength: Vector2 = Vector2.ZERO, stop_time: float = 0.6):
	if(knockback_strength != Vector2.ZERO):
		knockback = knockback_strength
		knockbackTween = get_tree().create_tween()
		knockbackTween.parallel().tween_property(self, "knockback", Vector2.ZERO, stop_time)


func takeDamage(damage):
	HEALTH -= damage
	if HEALTH <= 0:
		DEAD = true
		world.mob_count -= 1
		if world.mob_count == 0:
			world.max_reached = false
			world.wave += 1
			world.MAX_MOBS = RNG.randi_range(3, 10)
		queue_free()

	


func _on_spawn_timeout():
	state = 1


func _on_area_2d_body_entered(body):
	if(body.name == "Player"):
		state = 2


func _on_area_2d_body_exited(body):
	state = 1
