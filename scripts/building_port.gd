class_name BuildingPort
extends Resource

enum PortType {
	EXPORTS,
	IMPORTS
}

@export var port_type: PortType = PortType.EXPORTS
## offset relative to building origin
@export var cell_offset: Vector2i = Vector2i.ZERO
## (0, -1) = north, (1, 0) = east, (0, 1) = south, (-1, 0) = west
@export var facing: Vector2i = Vector2i(0, -1)
@export var storage : ItemStorage
