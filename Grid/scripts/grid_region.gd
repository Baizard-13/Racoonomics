@tool
class_name GridRegion
extends Node3D

## gridspace top-left (don't modify this directly, instead move the region in the editor and use the snap button)
@export var origin : Vector2i
@export var size := Vector2i.ONE:
	set(value):
		size = value
		_editor_update_visualization()
		#_update_game_view()

# @export_tool_button("Snap region to WorldGrid", 'SnapGrid') var snap_button = _editor_snap_self_to_grid # CURSE THIS BUTTON

@onready var game_grid_view: MeshInstance3D = $GameGridView
@onready var editor_visualizer: MeshInstance3D = $EditorVisualizer
@onready var editor_region_name: Label3D = $EditorVisualizer/Label3D

func contains(cell: Vector2i) -> bool:
	return cell.x >= origin.x and cell.x < origin.x + size.x and cell.y >= origin.y and cell.y < origin.y + size.y

func get_cells() -> Array[Vector2i]:
	var cells : Array[Vector2i]
	for x in range(origin.x, origin.x + size.x):
		for y in range(origin.y, origin.y + size.y):
			cells.append(Vector2i(x, y))
	return cells

func get_bounds() -> Rect2i:
	return Rect2i(origin, size)

func _ready() -> void:
	if !Engine.is_editor_hint():
		editor_visualizer.queue_free()
		set_process(false)
		_update_game_view()
	else:
		set_highlight_grid(true)

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

func set_highlight_grid(enable: bool) -> void:
	if enable: _update_game_view()
	$GameGridView.visible = enable

func _update_game_view() -> void:
	var grid = get_parent()
	if grid == null or !(grid is WorldGrid):
		return
	if !game_grid_view: game_grid_view = $GameGridView # godot is weird sometimes

	var cell_size : Vector2 = grid.cell_size
	game_grid_view.mesh.size = Vector3(size.x * cell_size.x, 2.0, size.y * cell_size.y)

	game_grid_view.material_override.set_shader_parameter("grid_size", Vector2(cell_size.x, cell_size.y))
	game_grid_view.material_override.set_shader_parameter("world_offset", grid.global_position)

func _process(_delta: float) -> void:
	if Engine.get_process_frames() % 10 == 0:
		_update_game_view()
		_editor_update_visualization()

func _get_configuration_warnings() -> PackedStringArray:
	var warnings = PackedStringArray()

	if size.x <= 0 || size.y <= 0:
		warnings.append("Region size must be greater than zero")

	if get_parent() == null or !(get_parent() is WorldGrid):
		warnings.append("GridRegion must be a child of a WorldGrid")

	return warnings
