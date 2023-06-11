extends Button

@onready var bubble = get_parent().get_node("Chat_Bubble")
@onready var banner = get_parent().get_node("Title_Banner")
@onready var title = get_parent().get_node("Label")
@onready var description_label = get_parent().get_node("Description_Label")
@onready var farmer = get_parent().get_node("Character")
@onready var story = get_parent().get_node("Story")
@onready var description = get_parent().get_node("Description")
@onready var background = get_parent().get_node("Start_background")

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("button_pressed", Callable(self, "_on_button_pressed"))# Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_pressed():
	bubble.visible = false
	banner.visible = false
	title.visible = false
	description_label.visible = false
	farmer.visible = false
	story.visible = false
	description.visible = false
	background.visible = false
	hide()


func _on_mouse_entered():
	var animator = $Panda_Button/AnimationPlayer
	animator.play("Attack")


func _on_mouse_exited():
	var animator = $Panda_Button/AnimationPlayer
	animator.stop()
