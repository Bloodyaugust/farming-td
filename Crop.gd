extends Sprite
class_name Crop

onready var actions = $"/root/actions"
onready var store = $"/root/store"

export var food_yield: int
export var floating_text: PackedScene
export var floating_text_color: Color
export var growth_time: float

var growth: float = 0.0

func _process(delta):
  growth += delta
  
  if growth >= growth_time:
    var state = store.state()
    
    growth = 0.0
    store.dispatch(actions.player_set_food(state["player"]["food"] + food_yield))
    
    var text = floating_text.instance()

    text.text_color = floating_text_color
    text.position = position
    text.get_node("text").text = "+" + str(food_yield)
    $"../".add_child(text)
  
  frame = floor((growth / growth_time) * hframes)
    