extends Node2D
class_name Mercenary

onready var store = $"/root/store"

onready var navigation: Navigation2D = $"../mercenary_navigation"
onready var range_indicator: Sprite = $"range"
onready var player_tilemap: TileMap = navigation.find_node("PlayerBaseLayerTilemap")
onready var tile: Vector2 = player_tilemap.world_to_map(position)

export var agility: int
export var attack_damage: int
export var attack_cooldown_min: float
export var attack_cooldown_max: float
export var attack_range: float
export var experience: int
export var experience_thresholds: PoolIntArray
export var stamina: int
export var strength: int

var attack_cooldown: float
var time_to_attack: float = 0
var indicator_base_size: float = 8
var target: WeakRef
var level: int = 0
var level_modifier: float = 0
var level_max: int

func _ready():
  attack_cooldown = attack_cooldown_max
  level_max = experience_thresholds.size()
  
  range_indicator.scale = range_indicator.scale * (attack_range / indicator_base_size)
  store.subscribe(self, "on_store_change")

func _process(delta):
  if time_to_attack > 0:
    time_to_attack -= delta
    if time_to_attack < 0:
      time_to_attack = 0

  if target != null and (!target.get_ref() or target.get_class() != "KinematicBody2D" or position.distance_to(target.position) >= attack_range):
    target = null
  else:
    find_target()

  if target != null and time_to_attack == 0:
    attack_target()

func on_store_change(type, state):
  if type == "player":
    if state["tile"] == tile:
      range_indicator.visible = true
    else:
      range_indicator.visible = false

func find_target():
  var enemies = get_tree().get_nodes_in_group("enemies")

  for enemy in enemies:
    if enemy.get_class() == "KinematicBody2D" and position.distance_to(enemy.position) <= attack_range:
      target = weakref(enemy)
      # TODO: Maybe connect an event here that is called when the target dies?
      break

func attack_target():
  var target_health = target.get_ref().get_node("actor_health")
  
  if target_health.health > 0:
    target_health.damage(attack_damage)
    time_to_attack = attack_cooldown
    # TODO: Grab XP from the enemy killed
    if level != level_max and target_health.health <= 0:
      experience += 1
    
      if experience >= experience_thresholds[level]:
        level_up()

func level_up():
  experience = experience - experience_thresholds[level]
  level += 1
  level_modifier = level / level_max
  
  attack_cooldown = lerp(attack_cooldown_max, attack_cooldown_min, level_modifier)
