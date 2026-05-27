class_name Food
extends Item

@export var components : Array[Produce]

func get_produce_types() -> Array[Global.ProduceType]:
	var types : Array[Global.ProduceType]
	for component in components:
		types.append(component.produce_type)

	return types
