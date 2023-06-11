extends Button

@onready var title = get_parent().get_node("Label")
@onready var freeplay_button = get_parent().get_node("Freeplay")
@onready var story_button = get_parent().get_node("Story")
@onready var game_description = get_parent().get_node("Description_Label")
@onready var chat_bubble = get_parent().get_node("Chat_Bubble")
@onready var banner = get_parent().get_node("Title_Banner")
# Called when the node enters the scene tree for the first time.
func _ready():
	game_description.visible = false
	chat_bubble.visible = false
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _on_mouse_entered():
	freeplay_button.visible = false
	game_description.visible = true
	story_button.visible = false
	chat_bubble.visible = true
	title.visible = false
	banner.visible = false
	

	
func _on_mouse_exited():
	freeplay_button.visible = true
	game_description.visible = false
	story_button.visible = true
	chat_bubble.visible = false
	title.visible = true
	banner.visible = true
