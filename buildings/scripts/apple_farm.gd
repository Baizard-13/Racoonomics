@tool
extends Building

func tick_produce(tick: int) -> void:
	print("prod %s" % tick)

func tick_consume(tick: int) -> void:
	print("cons %s" % tick)
