extends Node

var CharacterData = {}

var data_file_path = "res://Data/PandaBambooData.json"

func _ready():
	CharacterData = load_json_file(data_file_path)

func load_json_file(filePath : String):
	if FileAccess.file_exists(filePath):
		var dataFile = FileAccess.open(filePath, FileAccess.READ)
		var parsedResult = JSON.parse_string(dataFile.get_as_text())
		if parsedResult is Dictionary:
			return parsedResult
		else:
			print("parsed result not dictionary dummy")
	else:
		print("File doesn't exist you dummy")


