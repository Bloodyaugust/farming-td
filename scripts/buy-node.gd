extends Node2D

onready var actions = $"/root/actions"
onready var parent = $"../"
onready var store = $"/root/store"
onready var level_root = $"../../"
onready var player_tilemap: TileMap = level_root.find_node("PlayerBaseLayerTilemap")
onready var tilemap_cells: Array = player_tilemap.get_used_cells()

export var selected_node: PackedScene

func _process(delta):
  if Input.is_action_just_pressed("ui_select"):
    buy_node()
    
func buy_node():
  var new_node: Node2D = selected_node.instance()
  var node_position: Vector2 = player_tilemap.map_to_world(player_tilemap.world_to_map(parent.position))
  var store_state = store.state()
  var node_cost = new_node.get_node("cost")
  
  if node_cost.type == "gold":
    if store_state["player"]["gold"] >= node_cost.amount:
      level_root.add_child(new_node)
      new_node.position = node_position
      
      store.dispatch(actions.player_set_gold(store_state["player"]["gold"] - node_cost.amount))
