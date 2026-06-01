extends Node3D

@onready var world_grid: WorldGrid = $WorldGrid
@onready var build_mode_controller: Node = $BuildModeController

func _ready() -> void:
	world_grid._occupy_rect(Rect2i(3, -1, 1, 2), self)

func _input(event: InputEvent) -> void:
	if event.is_action_released("Info"):
		if not build_mode_controller.current_ghost:
			return
		var cell = build_mode_controller._hovered_cell()
		var building = world_grid.get_building_at_cell(cell)
		if building is Building:
			print(building.name)
