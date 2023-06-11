extends Node2D

var ui = Control.new()

func _ready():
	add_child(ui)
	ui.position = Vector2(0, 0)
	
	
