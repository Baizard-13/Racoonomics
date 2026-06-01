extends Node3D

@onready var world_grid: WorldGrid = $WorldGrid

func _ready() -> void:
	world_grid._occupy_rect(Rect2i(3, -1, 1, 2), self)
