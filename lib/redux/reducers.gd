extends Node

onready var types = get_node('/root/action_types')
onready var store = get_node('/root/store')

func game(state, action):
  if action['type'] == action_types.GAME_SET_START_TIME:
    var next_state = store.shallow_copy(state)
    next_state['start_time'] = action['time']
    return next_state
  return state

func player(state, action):
  if action['type'] == action_types.PLAYER_MOVE:
    var next_state = store.shallow_copy(state)
    next_state['position_x'] = action['vector'].x
    next_state['position_y'] = action['vector'].y
    return next_state
  if action['type'] == action_types.PLAYER_SET_HEALTH:
    var next_state = store.shallow_copy(state)
    next_state['health'] = action['health']
    return next_state
  if action['type'] == action_types.PLAYER_SET_STATE:
    var next_state = store.shallow_copy(state)
    next_state['state'] = action['state']
    return next_state
  return state

