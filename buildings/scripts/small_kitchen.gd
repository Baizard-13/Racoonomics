@tool
extends Building

var world_grid : WorldGrid

@onready var animation_player: AnimationPlayer = $Rig_Rabbit_001/AnimationPlayer

func _extends_ready() -> void:
	var parent_grid := get_parent() as WorldGrid
	if parent_grid:
		world_grid = parent_grid
	
	if !is_ghost:
		animation_player.play(&"Rig_Rabbit_001|Kithen_Lvl2_Work")


func tick_produce(tick: int) -> void:
	pass
