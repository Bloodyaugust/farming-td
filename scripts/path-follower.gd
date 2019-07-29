extends Node

const SPEED: float = 16.0 * 2.0
const NEAR: float = 1.0

onready var navigation: Navigation2D = $"/root".find_node("enemy_navigation", true, false)
onready var parent: Node2D = get_parent()

onready var path: PoolVector2Array = navigation.path

var path_index: int = 0

func _ready():
  print(path)

func _physics_process(delta):
  if (path):
    if path_index != path.size():
      var current_path_node: Vector2 = path[path_index]
      var distance_to_node: float = parent.position.distance_to(current_path_node)
    
      parent.move_and_collide((current_path_node - parent.position).normalized() * SPEED * delta)
      
      if parent.position.distance_to(current_path_node) <= NEAR:
        path_index += 1
