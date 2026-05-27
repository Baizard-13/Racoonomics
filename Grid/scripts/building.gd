@tool
class_name Building
extends Node3D

@export var title := "Unnamed Building"
@export var dimensions := Vector2i.ONE
## world-space origin
@export var origin_cell := Vector2i.ZERO
@export var invalid_cells : Array[Vector2i]
@onready var mesh_bounds_visualizer: MeshInstance3D = $MeshBoundsVisualizer

func get_cells() -> Array[Vector2i]:
	var cells : Array[Vector2i]
	for x in range(origin_cell.x, origin_cell.x + dimensions.x):
		for y in range(origin_cell.y, origin_cell.y + dimensions.y):
			cells.append(Vector2i(x, y))
	return cells