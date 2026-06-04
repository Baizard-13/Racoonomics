@tool
extends Building

# placeholder behavior to test item flow

func tick_produce(tick: int) -> void:
	if tick % 16 == 0:
		storage[&"carrots_out"].put(Global.get_type("carrots"), 1)
