extends Node

onready var types = get_node('/root/action_types')

signal player_damaged

func game_set_start_time(time):
  return {
    'type': types.GAME_SET_START_TIME,
    'time': time
  }

func player_damage(amount):
  emit_signal("player_damaged")
  return {
    'type': types.PLAYER_DAMAGE,
    'damage': amount
  }
  
func player_set_food(food):
  return {
    'type': types.PLAYER_SET_FOOD,
    'food': food
  }
  
func player_set_gold(gold):
  return {
    'type': types.PLAYER_SET_GOLD,
    'gold': gold
  }
  
func player_set_health(health):
  return {
    'type': types.PLAYER_SET_HEALTH,
    'health': health
  }
  
func player_set_state(state):
  return {
    'type': types.PLAYER_SET_STATE,
    'state': state
  }
