@tool
extends Building

@export var any_filter : ItemFilter
var world_grid : WorldGrid

func _extends_ready() -> void:
	var parent_grid := get_parent() as WorldGrid
	if parent_grid:
		world_grid = parent_grid


func tick_produce(tick: int) -> void:
	if tick % 16 == 0:
		storage[&"carrots_out"].put(Global.get_type("carrots"), 10)
		#print(storage[&"carrots_out"].take_filtered(any_filter, 1))
		print("создано ", storage[&"carrots_out"].stacks)
