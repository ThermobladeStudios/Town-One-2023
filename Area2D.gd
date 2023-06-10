extends Area2D

var maxHealth = 100
var currentHealth = 100

func _ready():
	currentHealth = maxHealth

func _process(delta):
	# Check if the object needs to be spawned randomly
	if currentHealth <= 0:
		queue_free()
		return

func apply_damage(damage_amount):
	currentHealth -= damage_amount

	# Check if the object is destroyed
	if currentHealth <= 0:
		destroy_object()

func destroy_object():
	# Handle the object being destroyed
	queue_free()
	# You can also play break animations, emit signals, or perform other actions here



func _on_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	pass # Replace with function body.
