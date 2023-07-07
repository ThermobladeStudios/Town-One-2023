extends Node2D

var enemy_1 = [preload("res://Bamboo Enemy/Bamboo.tscn"),preload("res://Bamboo Enemy/BigBamboo.tscn")]
var RNG = RandomNumberGenerator.new()
var MAX_MOBS = RNG.randi_range(3, 10)
var MAX_WAVES = 2
var mob_count = 0
var max_reached = false
var wave = 1
@onready var panda = []
@onready var allpandas = [preload("res://Panda/Panda.tscn"),preload("res://Panda/Panda.tscn"),preload("res://Panda/HeroPanda.tscn")]

var time = 0

var i = 0
func _process(delta):
	$Wave_count.text ="Wave: "+ str(wave)
	$Current_max_mobs.text = "Mobs this wave: " + str(MAX_MOBS)
	if(wave == MAX_WAVES):
		$"Panda Selection".visible = true
func _ready():
	$"Spawn Timer".start(0.5)
	for x in 3:
		panda.append(allpandas[x])
		
	
	$Timer.start(2)

func spawn_panda():
	var pandy = panda[i].instantiate()
	$Panda.add_child(pandy)
	pandy.position = Vector2(randi_range(58,565), randi_range(40,303))
	

	
func _on_timer_timeout():


	if(i < 2):
		spawn_panda()
	if (i < 2):
		i += 1


func _on_spawn_timer_timeout():
	if (mob_count < MAX_MOBS and !max_reached):
		mob_count += 1
		var rand = randi_range(0,100)
		var enemy = enemy_1[rand%2].instantiate()
	
		enemy.position = Vector2(randi_range(58,565), randi_range(40,303))
		#while enemy.position.x < 500 and enemy.position.x > -150 or enemy.position.y < 350 and enemy.position.y > -200:
			#enemy.position = Vector2(randf_range(-300,700), randf_range(-300,450))
		
		add_child(enemy)
	if mob_count == MAX_MOBS:
		max_reached = true
		time+=1
		if(time == 2):
			time = 0
			wave = 1
			$"Spawn Timer".stop()
	
	
	
