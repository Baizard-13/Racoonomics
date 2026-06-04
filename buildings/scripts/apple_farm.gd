@tool
extends Building

var world_grid : WorldGrid

var animation_speed: float = 1.0

@onready var animation_player: AnimationPlayer = $Anim_Farm_Apple_lvl1/Anim_Farm_Apple_lvl1/AnimationPlayer


func _extends_ready() -> void:
	var parent_grid := get_parent() as WorldGrid
	if parent_grid:
		world_grid = parent_grid
		
	if !is_ghost:
		animation_player.play(&"Anim_Farm_Apple_lvl1|Anim_Farm_Apple_lvl1|AppleTaking", -1, animation_speed)



func tick_produce(tick: int) -> void:
	if tick % 3 == 0:
		storage[&"apples_out"].put(Global.get_type("apples"), 5)
