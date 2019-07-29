extends Node2D

export(PackedScene) var enemy_scene: PackedScene

onready var level_root = $"/root/level_1"
  
func spawn_enemy():
  var enemy = enemy_scene.instance()
  
  enemy.position = global_position
  
  level_root.add_child(enemy)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#  pass


func _on_Timer_timeout():
  spawn_enemy()
