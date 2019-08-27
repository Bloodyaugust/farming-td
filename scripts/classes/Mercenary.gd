extends Node2D
class_name Mercenary

onready var store = $"/root/store"

onready var navigation: Navigation2D = $"../mercenary_navigation"
onready var range_indicator: Sprite = $"range"
onready var player_tilemap: TileMap = navigation.find_node("PlayerBaseLayerTilemap")
onready var tile: Vector2 = player_tilemap.world_to_map(position)

export var agility: int
export var attack_damage: float
export var attack_interval: float
export var attack_range: float
export var experience: float
export var level: int
export var stamina: float
export var strength: int

var attack_cooldown: float = 0
var indicator_base_size: float = 8
var target: WeakRef

func _ready():
  range_indicator.scale = range_indicator.scale * (attack_range / indicator_base_size)
  store.subscribe(self, "on_store_change")

func _process(delta):
  if attack_cooldown > 0:
    attack_cooldown -= delta
    if attack_cooldown < 0:
      attack_cooldown = 0

  if target != null and (!target.get_ref() or target.get_class() != "KinematicBody2D" or position.distance_to(target.position) >= attack_range):
    target = null
  else:
    find_target()

  if target != null and attack_cooldown == 0:
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
    target.get_ref().get_node("actor_health").damage(attack_damage)
    attack_cooldown = attack_interval
