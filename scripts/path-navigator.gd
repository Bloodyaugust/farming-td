extends Navigation2D

onready var end: Node2D = $"end_point"
onready var spawn: Node2D = $"spawn_point"

onready var path: PoolVector2Array = get_simple_path(spawn.position, end.position)
