@tool
class_name Building
extends Node3D

@export var title := "Unnamed Building" # probably not great to duplicate these across both Building and BuildingDefinition, but i can't think of another way to avoid a circular dependency. if you can, please do
@export var dimensions := Vector2i.ONE: # for the sake of my sanity we will assume the grid size is 1x1m
	set(value):
		dimensions = value
		_update_editor_vis()
## world-space origin
@export var origin_cell := Vector2i.ZERO
@export var invalid_cells : Array[Vector2i]
@export var ports : Array[BuildingPort]

@onready var mesh_bounds_visualizer: MeshInstance3D = $MeshBoundsVisualizer

func get_cells() -> Array[Vector2i]:
	var cells : Array[Vector2i]
	for x in range(origin_cell.x, origin_cell.x + dimensions.x):
		for y in range(origin_cell.y, origin_cell.y + dimensions.y):
			cells.append(Vector2i(x, y))
	return cells

func get_port_at_cell(cell: Vector2i) -> BuildingPort:
	for port in ports:
		var port_cell = origin_cell + port.cell_offset
		if port_cell == cell:
			return port
	return null

func _ready() -> void:
	if !Engine.is_editor_hint():
		mesh_bounds_visualizer.queue_free()

# wherever these will eventually be called, they must be called in this order specifically
func tick_produce() -> void:
	pass

func tick_transport() -> void:
	pass

func tick_consume() -> void:
	pass


func _update_editor_vis() -> void:
	if !Engine.is_editor_hint():
		return

func _rebuild_ports():
	pass # may or may not be needed
