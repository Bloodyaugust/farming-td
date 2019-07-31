extends Node2D
class_name Mercenary

onready var navigation: Navigation2D = $"../mercenary_navigation"

func _ready():
  print(navigation)
