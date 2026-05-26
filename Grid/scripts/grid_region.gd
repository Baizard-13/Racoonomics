@tool
class_name GridRegion
extends Node3D

## gridspace top-left
@export var origin : Vector2i
@export var size := Vector2i.ONE:
	set(value):
		size = value
		_editor_update_visualization()

@export_tool_button("Snap region to WorldGrid", 'SnapGrid') var snap_button = _editor_snap_self_to_grid

@onready var editor_visualizer: MeshInstance3D = $EditorVisualizer
@onready var editor_region_name: Label3D = $EditorVisualizer/Label3D

func contains(cell: Vector2i) -> bool:
	return cell.x >= origin.x and cell.x < origin.x + size.x and cell.y >= origin.y and cell.y < origin.y + size.y

func _ready() -> void:
	if !Engine.is_editor_hint():
		editor_visualizer.queue_free()
		set_process(false)

func _editor_snap_self_to_grid():
	var grid = get_parent()
	if grid == null or !(grid is WorldGrid):
		return

	var cell_size : Vector2 = grid.cell_size

	var top_left_world = global_position - Vector3(size.x * cell_size.x, 0, size.y * cell_size.y) * 0.5
	top_left_world.x = round(top_left_world.x / cell_size.x) * cell_size.x
	top_left_world.z = round(top_left_world.z / cell_size.y) * cell_size.y
	position = top_left_world + Vector3(size.x * cell_size.x, 0, size.y * cell_size.y) * 0.5

	origin = Vector2i(round(position.x / cell_size.x) - size.x / 2, round(position.z / cell_size.y) - size.y / 2)

	_editor_update_visualization()

func _editor_update_visualization():
	if !editor_visualizer:
		return

	var grid = get_parent()
	if grid == null or !(grid is WorldGrid):
		return

	var cell_size : Vector2 = grid.cell_size
	editor_visualizer.mesh.size = Vector3(size.x * cell_size.x, 2.0, size.y * cell_size.y)

	editor_visualizer.material_override.set_shader_parameter("cell_size", Vector2(cell_size.x, cell_size.y))
	editor_visualizer.material_override.set_shader_parameter("world_offset", grid.global_position)
	editor_visualizer.material_override.next_pass.set_shader_parameter("cell_size", Vector2(cell_size.x, cell_size.y)) # sorry
	editor_visualizer.material_override.next_pass.set_shader_parameter("world_offset", grid.global_position)

	editor_region_name.text = "%s (%dx%d)" % [name, size.x, size.y]

func _process(delta: float) -> void:
	_editor_update_visualization()

func _get_configuration_warnings() -> PackedStringArray:
	var warnings = PackedStringArray()

	if size.x <= 0 || size.y <= 0:
		warnings.append("Region size must be greater than zero")

	if get_parent() == null or !(get_parent() is WorldGrid):
		warnings.append("GridRegion must be a child of a WorldGrid")

	return warnings
