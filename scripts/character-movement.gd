extends KinematicBody2D

onready var actions = get_node('/root/actions')
onready var store = get_node('/root/store')

const WALK_SPEED = 16 * 3

var animator
var move_direction = "north" # north, east, south, west
var state = 0 # 0 = idle, 1 = moving


func _process(delta):
  var state_set = false
  
  if Input.is_action_pressed("ui_up"):
    state = 1
    move_direction = "north"
    state_set = true
  if Input.is_action_pressed("ui_right"):
    state = 1
    move_direction = "east"
    state_set = true
  if Input.is_action_pressed("ui_down"):
    state = 1
    move_direction = "south"
    state_set = true
  if Input.is_action_pressed("ui_left"):
    state = 1
    move_direction = "west"
    state_set = true
    
  if state_set == false && state != 0:
    state = 0
    state_set = true
    
  if state != 0:
    animator.play("walk-" + move_direction)
  else:
    animator.play("idle")
    
  if state_set:
    store.dispatch(actions.player_set_state(state))

func _physics_process(delta):
  if state == 1:
    match move_direction:
      "north":
        move_and_collide(Vector2(0, -1) * WALK_SPEED * delta)
      "east":
        move_and_collide(Vector2(1, 0) * WALK_SPEED * delta)
      "south":
        move_and_collide(Vector2(0, 1) * WALK_SPEED * delta)
      "west":
        move_and_collide(Vector2(-1, 0) * WALK_SPEED * delta)
      _:
        continue
        
func _ready():
  animator = get_node("AnimatedSprite")
  
  store.dispatch(actions.player_set_state(0))
