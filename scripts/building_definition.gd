class_name BuildingDefinition
extends Resource

@export var title := "Unnamed Building"
@export_multiline var description := "If you're seeing this, there's probably a bug"
@export var shop_icon : Texture2D

@export var dimensions := Vector2i.ONE
@export var clearance := 1
@export var ports : Array[BuildingPort]
@export var building_scene : PackedScene

@export var purchase_cost: int = 0
@export var upgrade_cost: int = 0

func get_building_instance() -> Building:
	var building = building_scene.instantiate() as Building
	building.title = title
	building.dimensions = dimensions
	building.ports = ports.duplicate(true)

	return building
