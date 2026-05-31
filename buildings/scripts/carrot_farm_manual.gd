@tool
extends Building

# placeholder behavior to test item flow

func tick_produce() -> void:
	storage[&"carrots_out"].put(Global.get_type("carrots"), 1)
