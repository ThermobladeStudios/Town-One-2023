extends CharacterBody2D
signal on_knockback

@export var speed = 100
@export var health = 60
@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")
var knockbackOnCD = false
var KNOCKBACKCD = 3

var state = 0
#0 is idle 1 is walk 2 is attack

func _ready():
	$ProgressBar.max_value = health
	state_machine.travel("Idle")

func _process(delta):
	$ProgressBar.value = health


func _input(event):
	if Input.is_key_pressed(KEY_ENTER):
		if(!knockbackOnCD):
			knockbackOnCD = true
			$CDTimer.start(KNOCKBACKCD)
			emit_signal("on_knockback")
			$Timer.start(0.4)
			state = 2

			
func _physics_process(delta):
	var input_direction = Vector2(Input.get_action_strength("Right") - Input.get_action_strength("Left") , Input.get_action_strength("Down") - Input.get_action_strength("Up")).normalized()
	velocity = input_direction*speed
	update_animation_parameters(input_direction)
	move_and_slide()
	pick_new_state()

func update_animation_parameters(move_input : Vector2):
	if(move_input != Vector2.ZERO):
		animation_tree.set("parameters/Walk/blend_position", move_input)
		animation_tree.set("parameters/Idle/blend_position", move_input)
		animation_tree.set("parameters/Attack/blend_position", move_input)

func pick_new_state():
	if(state == 1):
		state_machine.travel("Walk")

	elif(state == 0):
		state_machine.travel("Idle")
	elif(state == 2):
		state_machine.travel("Attack")

func _on_area_2d_body_entered(body):
	if("BambooBody" in body.name):
		health -= (JsonData.CharacterData["Bamboo"]["Attack"])
		if health <= 0 :
			get_tree().paused = true




func _on_cd_timer_timeout():
	knockbackOnCD = false
	$CDTimer.stop()
	


func _on_timer_timeout():
	state = 1
	$Timer.stop()
