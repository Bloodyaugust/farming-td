extends Particles2D

onready var character: KinematicBody2D = $"../../"

func _process(delta):
  if character.state == 0 and emitting:
    emitting = false
  elif character.state != 0 and not emitting:
    emitting = true
