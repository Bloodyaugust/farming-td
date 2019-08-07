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
  var store_state = store.state()
  
  var new_node: Node2D = selected_node.instance()
  var current_tile: Vector2 = store_state["player"]["tile"]
  var node_position: Vector2 = player_tilemap.map_to_world(current_tile) + (player_tilemap.cell_size / 2)
  var node_cost = new_node.get_node("cost")
  
  if node_cost.type == "gold":
    if store_state["player"]["gold"] >= node_cost.amount and not store_state["tiles"].has(current_tile):
      level_root.add_child(new_node)
      new_node.position = node_position
      
      store.dispatch(actions.tiles_set_child(current_tile, new_node))
      store.dispatch(actions.player_set_gold(store_state["player"]["gold"] - node_cost.amount))
