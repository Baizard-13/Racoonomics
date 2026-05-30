@tool
class_name Building
extends Node3D

const BUILDING_PORT_DECAL = preload("uid://uf7gdg37kqtl")

@export var title := "Unnamed Building" # probably not great to duplicate these across both Building and BuildingDefinition, but i can't think of another way to avoid a circular dependency. if you can, please do

@export var dimensions := Vector2i.ONE:
	set(value):
		dimensions = value
		_update_editor_vis()
@export var clearance := 1
@export var grid_size := 10.0 # for the sake of my sanity we will assume this is fixed
@export var bound_vis_padding := 0.01
@export var ports : Array[BuildingPort]
## needed for material overrides, remember to NOT add MeshBoundsVisualizer to this list
@export var meshes : Array[MeshInstance3D]

@export_tool_button("Rebuild ports") var rebuild_ports_button = _rebuild_ports

@export_category("Runtime state (don't edit)")

## world-space origin
@export var origin_cell := Vector2i.ZERO:
	set(value):
		origin_cell = value
		if is_inside_tree():
			update_position()

@export var invalid_cells : Array[Vector2i]
@export var is_active := false
@export var is_ghost := false

@onready var mesh_bounds_visualizer: MeshInstance3D = $MeshBoundsVisualizer

var ports_node: Node3D

func get_local_top_left() -> Vector3:
	return Vector3(-dimensions.x * grid_size, 0, -dimensions.y * grid_size) * 0.5

func top_left_to_pos(cell: Vector2i) -> Vector3:
	var local_top_left = get_local_top_left()
	return local_top_left + Vector3((cell.x + 0.5) * grid_size, 0, (cell.y + 0.5) * grid_size)

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
	_rebuild_ports()
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
	# position = grid.cell_to_world(origin_cell) - get_local_top_left()
	position = grid.cell_to_world(origin_cell)
	reset_physics_interpolation()

func _rebuild_ports():
	if ports_node:
		ports_node.queue_free()
	ports_node = Node3D.new()
	ports_node.name = "Ports"
	add_child(ports_node)

	for port in ports:
		var port_instance : Node3D = BUILDING_PORT_DECAL.instantiate()
		var port_pos = get_local_top_left() + Vector3((port.cell_offset.x + 0.5) * grid_size, 0, (port.cell_offset.y + 0.5) * grid_size)
		port_instance.position = port_pos
		ports_node.add_child(port_instance)
		port_instance.set_is_output(port.port_type == BuildingPort.PortType.EXPORTS)
		port_instance.rotation.y = atan2(port.facing.x, port.facing.y)
