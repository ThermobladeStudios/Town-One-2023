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

func get_Type():
	return bambooType

func _ready():
	$ProgressBar.max_value = HEALTH
	player.on_knockback.connect(self.knockback_handler)
	
func knockback_handler():
	var player_position = player.position
	var target_position = (player_position-position).normalized()
	_hit(target_position*KNOCKBACKSTRENGTH)

func _process(delta):
	$ProgressBar.value = HEALTH

func _physics_process(delta):
	findPlayer()



func findPlayer():
	var player_position = player.position
	var target_position = (player_position-position).normalized()
	velocity = target_position*SPEED + knockback
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
		
	
