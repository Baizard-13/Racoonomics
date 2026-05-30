extends Node3D

@onready var world_grid: WorldGrid = $WorldGrid

func _ready() -> void:
	world_grid._occupy_rect(Rect2i(4, 0, 1, 2), name)
