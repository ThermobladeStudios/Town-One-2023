extends Button

@onready var start_button = get_parent().get_node("Button")
@onready var game_description = get_parent().get_node("Label")
# Called when the node enters the scene tree for the first time.
func _ready():
	game_description.visible = false
	text = "HOVER OVER\nto see Game Description"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _on_mouse_entered():
	print("Is this working")
	game_description.visible = true
	start_button.visible = false

	
func _on_mouse_exited():
	
	game_description.visible = false
	start_button.visible = true
	
