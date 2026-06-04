@tool
extends Building

@export var any_filter : ItemFilter

@onready var animation_player: AnimationPlayer = $lavka_lvl2/AnimationPlayer

var animation_speed: float = 1.0

var world_grid : WorldGrid

var import : BuildingPort

func _extends_ready() -> void:
	var parent_grid := get_parent() as WorldGrid
	if parent_grid:
		world_grid = parent_grid

	import = ports[0]
	
	if !is_ghost:
		animation_player.play(&"Rig_Rabbit|Work", -1, animation_speed)

func tick_consume(tick: int) -> void:
	var total_satiety := 0
	for item_id in storage[&"food_input"].stacks:
		var item_type : ItemType = Global.get_type(item_id)
		total_satiety += item_type.satiety
	storage[&"food_input"].stacks.clear()
	Global.add_loyalty(total_satiety)
	
