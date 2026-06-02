@tool
extends Building

# placeholder behavior to test item flow

func tick_produce() -> void:
	if Engine.get_physics_frames() % 32 == 0:
		storage[&"carrots_out"].put(Global.get_type("carrots"), 1)
