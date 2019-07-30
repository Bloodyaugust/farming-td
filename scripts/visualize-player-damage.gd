extends Node

export var damage_effect_degrade_rate: float

onready var actions = $"/root/actions"
onready var animated_sprite = $"../AnimatedSprite"

var damage_shader_amount: float = 0.0

func _ready():
  actions.connect("player_damaged", self, "on_damage")
  on_damage()
  
func _process(delta):
  if damage_shader_amount > 0.0:
    damage_shader_amount -= delta * damage_effect_degrade_rate
    
    if damage_shader_amount < 0.0:
      damage_shader_amount = 0.0
      
    animated_sprite.material.set_shader_param("amount", damage_shader_amount)

func on_damage():
  damage_shader_amount = 1.0
