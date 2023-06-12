extends Control

var Index
var RNG = RandomNumberGenerator.new()
var ListOfPandas = ["Giant Panda", "Red Panda", "Hero Panda"]
var ListOfPandaImages = ["res://Assets/GiantPanda.png", "res://Assets/RedPanda.png", "res://Assets/HeroPanda.png"]
var ListOfPandaScenes = [preload("res://Panda/GiantPanda.tscn"), preload("res://Panda/Panda.tscn") ]
var RarityGradients = [PackedColorArray()]
@onready var pandaNode = get_node("/root/Game Screen/World/Panda")
func _ready():
	Index = RNG.randi_range(0,1)
	var Panda = ListOfPandas[Index]
	var PandaJSON = JsonData.CharacterData[Panda]
	$Name.text = Panda
	$Attack.text = str(PandaJSON["Attack"])
	$Description.text = str(PandaJSON["Description"])
	$Image.texture = load(ListOfPandaImages[Index])

func _on_pressed():
	var pandaaa= ListOfPandaScenes[Index]
	pandaNode.add_child(pandaaa.instantiate())
	pandaaa.position = get_node("root/Game Scene/World/")
	
	get_parent().visible = false
