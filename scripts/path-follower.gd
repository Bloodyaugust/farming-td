extends Node

onready var navigation: Navigation2D = $"/root".find_node("enemy_navigation", true, false)

func _ready():
  print(navigation)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#  pass
