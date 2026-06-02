@tool
extends Building

var world_grid : WorldGrid

var export : BuildingPort
var out_port_storage = ItemStorage

func _extends_ready() -> void:
	var parent_grid := get_parent() as WorldGrid
	if parent_grid:
		world_grid = parent_grid
	
	export = ports[0]
	out_port_storage = get_port_storage(export)

func tick_produce() -> void:
	if Engine.get_physics_frames() % 32 == 0:
		storage[&"carrots_out"].put(Global.get_type("carrots"), 10)
