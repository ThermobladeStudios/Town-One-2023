extends Control


@onready var world = preload("res://Worlds/World.tscn")



	

	




func _on_button_pressed():
	$".".add_child(world.instantiate())
	print($".")
	


func _on_freeplay_pressed():
	$".".add_child(world.instantiate())
