extends Node

onready var actions = $"/root/actions"
onready var navigation: Navigation2D = $"/root".find_node("enemy_navigation", true, false)
onready var parent: Node2D = get_parent()
onready var path_follower = $"../path_follower"
onready var store = $"/root/store"

# Called when the node enters the scene tree for the first time.
func _ready():
  path_follower.connect("path_complete", self, "on_path_complete")

func on_path_complete():
  store.dispatch(actions.player_damage(1))
  parent.queue_free()
