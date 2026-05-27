class_name WorldGrid
extends Node3D

@export var cell_size := Vector2.ONE
@export var region_bounds : Array[Rect2i]
@export var occupied_bounds : Array[Rect2i]

var valid_cells : Dictionary[Vector2i, bool]
var occupied_cells : Dictionary[Vector2i, StringName]

func world_to_cell(world_pos: Vector3) -> Vector2i:
	return Vector2i(round(world_pos.x / cell_size.x), round(world_pos.z / cell_size.y))

func cell_to_world(cell: Vector2i) -> Vector3:
	return Vector3(cell.x * cell_size.x, 0, cell.y * cell_size.y)

func _occupy_rect(rect: Rect2i, object_name: StringName) -> void:
	occupied_bounds.append(rect)
	for x in range(rect.position.x, rect.position.x + rect.size.x):
		for y in range(rect.position.y, rect.position.y + rect.size.y):
			var cell = Vector2i(x, y)
			occupied_cells[cell] = object_name

func _free_rect(rect: Rect2i) -> void:
	occupied_bounds.erase(rect)
	for x in range(rect.position.x, rect.position.x + rect.size.x):
		for y in range(rect.position.y, rect.position.y + rect.size.y):
			var cell = Vector2i(x, y)
			occupied_cells.erase(cell)

func _ready() -> void:
	for child in get_children():
		if child is GridRegion:
			var region = child as GridRegion
			region_bounds.append(region.get_bounds())
			for cell in region.get_cells():
				valid_cells[cell] = true

func get_overlap(rect: Rect2i) -> Array[Vector2i]:
	var overlap_cells : Array[Vector2i]
	for x in range(rect.position.x, rect.position.x + rect.size.x):
		for y in range(rect.position.y, rect.position.y + rect.size.y):
			var cell = Vector2i(x, y)
			if valid_cells.has(cell) and occupied_cells.has(cell):
				overlap_cells.append(cell)
	return overlap_cells

func get_building_at_cell(cell: Vector2i) -> StringName:
	if occupied_cells.has(cell):
		return occupied_cells[cell]
	return ""

func try_place_building(building: Building) -> bool:
	var building_cells = building.get_cells()
	for cell in building_cells:
		if !valid_cells.has(cell) or occupied_cells.has(cell):
			return false

	var building_rect = Rect2i(building.origin_cell, building.dimensions)
	_occupy_rect(building_rect, building.title)
	if building.get_parent() != self:
		add_child(building)

	return true
