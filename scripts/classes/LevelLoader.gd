extends Node
class_name LevelLoader

onready var parent = $"../" 

onready var level_json = _load_level().result

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
  print("res://data/" + parent.name + ".json")
  print(level_json)

func _load_level():
  var file = File.new()
  file.open("res://data/" + parent.name + ".json", File.READ)
  
  var json = file.get_as_text()
  print(json)
  file.close()
  
  var parsed_json = JSON.parse(json)
  print(parsed_json)
  
  return parsed_json.result