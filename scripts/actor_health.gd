extends Node

signal actor_died

export var health: int
export var damage_effect_degrade_rate: float

onready var animated_sprite = $"../AnimatedSprite"

var damage_shader_amount: float = 0.0

func _ready():
  damage(1)

func _process(delta):
  if damage_shader_amount > 0.0:
    damage_shader_amount -= delta * damage_effect_degrade_rate
    
    if damage_shader_amount < 0.0:
      damage_shader_amount = 0.0
      
    animated_sprite.material.set_shader_param("amount", damage_shader_amount)

func damage(amount: int):
  health -= amount
  
  if health <= 0:
    emit_signal("actor_died")
    $"../".queue_free()
  else:
    damage_shader_amount = 1.0
