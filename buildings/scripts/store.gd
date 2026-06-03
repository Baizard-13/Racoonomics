@tool
extends Building

@export var any_filter : ItemFilter

var world_grid : WorldGrid

var import : BuildingPort
var selled := 0

func _extends_ready() -> void:
	var parent_grid := get_parent() as WorldGrid
	if parent_grid:
		world_grid = parent_grid

	
	import = ports[0]
	

func tick_consume(tick: int) -> void:
	print(storage[&"food_input"].take_filtered(any_filter, 2))
	
	var total_satiety := 0
	for item_id in storage[&"food_input"].stacks:
		var item_type : ItemType = Global.get_type(item_id)
		total_satiety += item_type.satiety
	storage[&"food_input"].stacks.clear()
	Global.add_loyalty(total_satiety)
	
	
