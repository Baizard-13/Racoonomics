@tool
class_name Building
extends Node3D

@export var title := "Unnamed Building" # probably not great to duplicate these across both Building and BuildingDefinition, but i can't think of another way to avoid a circular dependency. if you can, please do
@export var dimensions := Vector2i.ONE:
	set(value):
		dimensions = value
		_update_editor_vis()
@export var grid_size := 10.0 # for the sake of my sanity we will assume this is fixed
@export var bound_vis_padding := 0.01
@export var ports : Array[BuildingPort]
## needed for material overrides, remember to NOT add MeshBoundsVisualizer to this list
@export var meshes : Array[MeshInstance3D]

@export_category("Runtime state (don't edit)")

## world-space origin
@export var origin_cell := Vector2i.ZERO:
	set(value):
		origin_cell = value
		if is_inside_tree():
			var grid := get_parent() as WorldGrid
			position = grid.cell_to_world(origin_cell)
@export var invalid_cells : Array[Vector2i]
@export var is_active := false
@export var is_ghost := false

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

func set_material_override(material: Material):
	for mesh in meshes:
		mesh.material_override = material

func set_override_property(property_name: StringName, value):
	for mesh in meshes:
		if mesh.material_override:
			mesh.material_override.set_shader_parameter(property_name, value)

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

	if mesh_bounds_visualizer:
		mesh_bounds_visualizer.scale = Vector3(dimensions.x * grid_size + bound_vis_padding, 1, dimensions.y * grid_size + bound_vis_padding)

func update_position() -> void:
	var grid := get_parent() as WorldGrid
	position = grid.cell_to_world(origin_cell)

func _rebuild_ports():
	pass # may or may not be needed
