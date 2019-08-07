extends Node2D
class_name Mercenary

onready var navigation: Navigation2D = $"../mercenary_navigation"
onready var range_indicator: Sprite = $"range"

export var attack_damage: float
export var attack_interval: float
export var attack_range: float

var attack_cooldown: float = 0
var indicator_base_size: float = 8
var target: Node2D

func _ready():
  range_indicator.scale = range_indicator.scale * (attack_range / indicator_base_size)
  
func _process(delta):
  if attack_cooldown > 0:
    attack_cooldown -= delta
    if attack_cooldown < 0:
      attack_cooldown = 0
  
  if is_instance_valid(target):
    if position.distance_to(target.position) >= attack_range:
      target = null
  else:
    find_target()
    
  if attack_cooldown == 0:
    attack_target()
  
func find_target():
  var enemies = get_tree().get_nodes_in_group("enemies")
  
  for enemy in enemies:
    if position.distance_to(enemy.position) <= attack_range:
      target = enemy
      break
  
func attack_target():
  if is_instance_valid(target) && target.get_node("actor_health") != null:
    target.get_node("actor_health").damage(attack_damage)
    attack_cooldown = attack_interval