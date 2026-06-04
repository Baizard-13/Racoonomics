@tool
extends Building

var world_grid : WorldGrid
var cooked_item : ItemType
#var cooked_amount : int


@onready var animation_player: AnimationPlayer = $Rig_Rabbit_001/AnimationPlayer

func _extends_ready() -> void:
	var parent_grid := get_parent() as WorldGrid
	if parent_grid:
		world_grid = parent_grid
	
	if !is_ghost:
		animation_player.play(&"Rig_Rabbit_001|Kithen_Lvl2_Work")
	


func tick_produce(tick: int) -> void:
	if cooked_item:
		storage[&"cook_out"].put(cooked_item, 1)
		cooked_item = null
	
func tick_consume(tick: int) -> void:
	for item_id in storage[&"cook_in"].stacks:
		cooked_item = get_recipe(Global.get_type(item_id))
		storage[&"cook_in"].stacks.erase(item_id)

func get_recipe(produce_food: ItemType) -> ItemType:
		return small_recipes.get(produce_food, ItemType)
