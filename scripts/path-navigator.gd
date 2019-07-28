extends Navigation2D

onready var end: Node2D = $"end_point"
onready var spawn: Node2D = $"spawn_point"

onready var path: PoolVector2Array = get_simple_path(spawn.position, end.position)

func _ready():
  var global_path: Array = []
  
  for vector in path:
    global_path.push_back(to_global(vector))
    
  path = PoolVector2Array(global_path)
