extends Line2D

onready var navigation: Navigation2D = $"/root".find_node("enemy_navigation", true, false)

func _ready():
  points = navigation.path
