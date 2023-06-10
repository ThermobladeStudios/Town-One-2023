extends Node2D

var enemy_1 = preload("res://Bamboo Enemy/Bamboo.tscn")
var MAX_MOBS = 5
var mob_count = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_spawn_timer_timeout():
	if (mob_count < MAX_MOBS):
		mob_count += 1
		var enemy = enemy_1.instantiate()
		
		enemy.position = Vector2(randf_range(-300,700), randf_range(-300,450))
	
		while enemy.position.x < 500 and enemy.position.x > -150 or enemy.position.y < 350 and enemy.position.y > -200:
			enemy.position = Vector2(randf_range(-300,700), randf_range(-300,450))
		
		add_child(enemy)
		
		
	
	
