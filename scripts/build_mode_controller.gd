extends Node

const _2X_2_TEST_BUILDING = preload("uid://c8lmno2gm42xg")

@export var buildings : Array[BuildingDefinition]

@export var grid : WorldGrid
@export var camera : Camera3D

@export var building_ghost_material : ShaderMaterial

@export_category("Runtime state (don't edit)")
@export var current_building : BuildingDefinition = null

@onready var post_process_quad: MeshInstance3D = $PostProcessQuad

var current_ghost : Building
var current_grid_pos : Vector2i

func _ready() -> void:
	enter_build_mode(_2X_2_TEST_BUILDING)

func _process(_delta: float) -> void:
	if !current_building or !current_ghost:
		return

	var mouse_grid_pos := _hovered_cell()

	if mouse_grid_pos != current_grid_pos:
		current_grid_pos = mouse_grid_pos

		current_ghost.origin_cell = current_grid_pos

		var is_valid := grid.get_overlap_with_clearance(Rect2i(current_ghost.origin_cell, current_building.dimensions), current_building.clearance).is_empty()
		current_ghost.set_override_property("is_valid", is_valid)

func enter_build_mode(building_def: BuildingDefinition) -> void:
	current_building = building_def
	if current_ghost:
		current_ghost.queue_free()

	current_ghost = building_def.get_building_instance()
	current_ghost.set_material_override(building_ghost_material)
	current_ghost.set_override_property("is_valid", true)
	current_ghost.is_ghost = true

	grid.set_draw_grid(true)
	grid.add_child(current_ghost)
	post_process_quad.show()

func exit_build_mode() -> void:
	current_building = null
	grid.set_draw_grid(false)
	post_process_quad.hide()
	current_grid_pos = Vector2.ZERO
	if current_ghost:
		current_ghost.queue_free()
		current_ghost = null

func _hovered_cell() -> Vector2i:
	var viewport := get_viewport()
	var mouse_pos := viewport.get_mouse_position()

	var ray_origin := camera.project_ray_origin(mouse_pos)
	var ray_direction := camera.project_ray_normal(mouse_pos)

	var target := -ray_origin.y / ray_direction.y
	var intersection := ray_origin + ray_direction * target

	return grid.world_to_cell(intersection)

func _try_place_building() -> void:
	if !current_building or !current_ghost:
		return

	var placed_building = current_building.get_building_instance()
	placed_building.origin_cell = current_grid_pos

	if !grid.try_place_building(placed_building):
		placed_building.queue_free()
	else:
		exit_build_mode()

func _input(event: InputEvent) -> void:
	if !current_building or !current_ghost:
		if event.is_action_pressed("bm_enter"):
			enter_build_mode(_2X_2_TEST_BUILDING)
		return

	if event.is_action_pressed("place_building"):
		_try_place_building()
	if event.is_action_pressed("bm_exit"):
		exit_build_mode()
