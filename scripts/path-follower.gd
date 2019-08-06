extends Node

const SPEED: float = 16.0 * 2.0
const NEAR: float = 1.0

onready var navigation: Navigation2D = $"/root".find_node("enemy_navigation", true, false)
onready var parent: Node2D = get_parent()
onready var sprite: AnimatedSprite = parent.get_node("AnimatedSprite")

onready var path: PoolVector2Array = navigation.path

signal path_complete

var path_index: int = 0
var move_direction: String = "south"

func _process(delta):
  sprite.play("walk-" + move_direction)

func _physics_process(delta):
  if (path):
    if path_index != path.size():
      var current_path_node: Vector2 = path[path_index]
      var distance_to_node: float = parent.position.distance_to(current_path_node)
      var move_vector: Vector2 = (current_path_node - parent.position).normalized() * SPEED * delta
      
      if abs(move_vector.y) > abs(move_vector.x):
        if move_vector.y < 0:
          move_direction = "north"
        if move_vector.y > 0:
          move_direction = "south"
      else:
        if move_vector.x > 0:
          move_direction = "east"
        if move_vector.x < 0:
          move_direction = "west"
    
      parent.move_and_collide(move_vector)
      
      if parent.position.distance_to(current_path_node) <= NEAR:
        path_index += 1
    else:
      emit_signal("path_complete")