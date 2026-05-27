@tool
class_name Building
extends Node3D

@export var title := "Unnamed Building"
@export var dimensions := Vector2i.ONE # for the sake of my sanity we will assume the grid size is 1x1m.
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

# func tick() -> void:
# 	print("someone didn't override tick(), please do (building %s)" % name)

# wherever these will eventually be called, they must be called in this order specifically
func tick_produce() -> void:
	pass

func tick_transport() -> void:
	pass

func tick_consume() -> void:
	pass


func update_editor_vis() -> void:
	pass

func _rebuild_ports():
	pass
