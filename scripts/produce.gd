class_name Produce
extends Item

@export var produce_type: Global.ProduceType

func get_type_name() -> String:
	match produce_type:
		Global.ProduceType.CARROT:
			return "Морковь"
		Global.ProduceType.NUT:
			return "Орехи"
		Global.ProduceType.APPLE:
			return "Яблоки"
		Global.ProduceType.WOOD:
			return "Дерево"
		Global.ProduceType.MEAT:
			return "Мясо"
		Global.ProduceType.FLIES:
			return "Мухи"
		_:
			return "???"

func get_produce_types() -> Array[Global.ProduceType]:
	return [produce_type]
