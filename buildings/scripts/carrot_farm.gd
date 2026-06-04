@tool
extends Building

var animation_speed: float = 1.0

var world_grid : WorldGrid

@onready var animation_player: AnimationPlayer = $Carrot_lvl1_work/AnimationPlayer


func _extends_ready() -> void:
	var parent_grid := get_parent() as WorldGrid
	if parent_grid:
		world_grid = parent_grid
		
	if !is_ghost:
		animation_player.play(&"Anim_Farm_Carrot_lvl1|Anim_Farm_Carrot_lvl1|Anim_Farm_Carrot_lvl1", -1, animation_speed)


func tick_produce(tick: int) -> void:
	if tick % 3 == 0:
		storage[&"carrots_out"].put(Global.get_type("carrots"), 5)
